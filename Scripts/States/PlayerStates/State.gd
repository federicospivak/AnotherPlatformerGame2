extends Node
class_name State
@onready var state_machine = %StateMachine

@export
var animation_name: String
@export
var move_speed: float = 130

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

## Hold a reference to the parent so that it can be controlled by the state
var parent: CharacterBody

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return force_state()

func process_physics(delta: float) -> State:
	return null

func force_state() -> State:
	if state_machine.call_pushback:
		return state_machine.pushback_state
	return null
	
