extends Node2D
@onready var sprite_2d = $Area2D/Sprite2D

signal fruit_collected


func _on_area_2d_body_entered(body):
	queue_free()
	fruit_collected.emit()
