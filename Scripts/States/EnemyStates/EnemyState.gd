extends Node
class_name enemy_state
@onready var state_machine = $".."

@export
var animation_name: String
@export
var move_speed: float = 130

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Hold a reference to the parent so that it can be controlled by the state
var parent: Node2D

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_frame(delta: float) -> enemy_state:
	return force_state()

func process_physics(delta: float) -> enemy_state:
	return null

func force_state() -> enemy_state:
	if state_machine.call_pushback:
		return state_machine.pushback_state
	return null
	
