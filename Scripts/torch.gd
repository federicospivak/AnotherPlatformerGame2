extends Node2D
class_name torch

@onready var ray_cast_2d = $RayCast2D

signal light_entered
signal light_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if ray_cast_2d.is_colliding():
		##if ray_cast_2d.get_collision_mask_value(2):
		#var enemy = ray_cast_2d.get_collider()
		##print("IS COLLIDING! :)")
		#light_entered.emit(enemy)
	#else:
		#ray_cast_2d.rotate(20)

func _on_area_2d_area_entered(area):
	if area.name == 'LightExclusion':
		light_entered.emit(area)


func _on_area_2d_area_exited(area):
	if area.name == 'LightExclusion':
		light_exit.emit(area)
