extends State
class_name RangeAttackState

#@export
#var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var fall_state: State
@export
var jump_state: State
@export
var aim_state: State

const ArrowScene := preload("res://Scenes/Arrow.tscn")

var anim_finished: bool

@onready var aim_pointer = %AimPointer


func enter() -> void:
	super()
	parent.animations.connect("animation_finished", Callable(self, "_on_anim_finished"))
	shoot(ArrowScene)

func process_frame(delta: float) -> State:
	return super(delta)
	
func process_input(event: InputEvent) -> State:
	if ( Input.is_action_just_pressed('Jump') or parent.forceJump ) and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	
	parent.velocity.y += gravity * delta
	
	if anim_finished:
		anim_finished = false
		
		if !parent.is_on_floor():
			return fall_state
			
		if Input.is_action_pressed('Aim'):
			return aim_state
		else:
			return idle_state
	
	parent.move_and_slide()
		
	return null

func shoot(projectile: PackedScene) -> void:
	var bullet := projectile.instantiate()
	bullet.position = aim_pointer.global_position
	bullet.direction = parent.global_position.direction_to(aim_pointer.global_position)
	add_child(bullet)

func _on_anim_finished(anim_name: String):
	anim_finished = true
