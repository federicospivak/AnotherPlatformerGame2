extends Sprite2D

signal sword_collected



func _on_sword_collision_body_entered(body):
	queue_free()
	GlobalVariables.able_attack = true
	sword_collected.emit()
