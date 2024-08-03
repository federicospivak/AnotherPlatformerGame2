extends Area2D
class_name HitBox

@export var damage := 10

@onready var collision_shape := $CollisionShape2D

func set_disabled(is_disabled: bool) -> void:
	collision_shape.set_deferred("disabled", is_disabled)
