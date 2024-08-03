extends Area2D

@export var health : HealthComponent

signal collision_detected
signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	health.health_reached_zero.connect(on_death)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_entered(area):
	collision_detected.emit(area)
	
func on_death():
	death.emit()
	
