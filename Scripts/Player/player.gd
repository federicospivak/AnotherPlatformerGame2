extends Node2D
class_name Player

@export var health : HealthComponent
@onready var sprite_2d = $CharacterBody2D/Sprite2D
@onready var animation = $CharacterBody2D/AnimationPlayer
@onready var character_body_2d = %CharacterBody2D

var shader : ShaderMaterial

var fruits_collected: int

signal player_was_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	set_signals()
	shader = sprite_2d.material
	shader.set_shader_parameter("flash_modifier", 0)
	GlobalVariables.player = self

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func set_signals():
	var path: String = "/root/"+get_parent().name+"/Enemies"
	var enemies = get_node(path)
	if enemies != null:
		for enemy in enemies.get_children():
			enemy.damage_player.connect(_on_damage_player)

func _on_fruit_fruit_collected():
	fruits_collected += 1

func _on_floating_enemy_player_death():
	pass

func _on_itemsword_sword_collected():
	GlobalVariables.able_attack = true

func _on_damage_player(enemy: floating_enemy, damage:int):
	health.damage(damage)
	player_was_hit.emit(enemy)

