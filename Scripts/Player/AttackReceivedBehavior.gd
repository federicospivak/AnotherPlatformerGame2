extends Node
@onready var initial_timer = $InitialTimer
@onready var character_body_2d = %CharacterBody2D
@onready var state_machine = %StateMachine


var shader : ShaderMaterial
var pushback : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite_2d = get_parent()
	if sprite_2d is Sprite2D:
		shader = sprite_2d.material

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func invulnerability(mode:bool):
	character_body_2d.set_collision_layer_value(1, !mode)
	character_body_2d.set_collision_layer_value(15, mode)

func _on_initial_timer_timeout():
	shader.set_shader_parameter("flash_modifier", 0)
	invulnerability(false)
	

func _on_player_player_was_hit(enemy:floating_enemy):
	initial_timer.start()
	shader.set_shader_parameter("flash_modifier", 1)
	print("Enemy ->"+str(enemy.global_position.x))
	print("Player ->"+str(character_body_2d.global_position.x))
	var right_direction : bool
	if enemy.global_position.x < character_body_2d.global_position.x:
		right_direction = true
	else:
		right_direction = false
	state_machine.set_pushback(true, right_direction)
	invulnerability(true)
