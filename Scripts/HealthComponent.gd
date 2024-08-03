extends Node
class_name HealthComponent

@export var max_health: int
@export var health: int
@export var show_bar: bool = true

@onready var health_bar = $HealthBar

signal health_changed
signal health_reached_zero
signal pushback

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health
	
	init_healthbar()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func damage(value: int):
	health -= value
	health_bar.value = health
	health_changed.emit(health)
	pushback.emit()
	
	if health <= 0:
		health_reached_zero.emit()
	

func init_healthbar():
	health_bar.visible = show_bar
	
	health_bar.max_value = max_health
	health_bar.value = health
