extends Node
class_name enemy_state_machine

@onready var playerBody = %CharacterBody2D

@export
var starting_state: enemy_state
@export
var pushback_state: enemy_state

var current_state: enemy_state
@export var label_action = Label

@onready var health_component = $"../HealthComponent"

var call_pushback: bool
var pushback_direction_right: bool
var call_chasing: bool
var ready_to_attack: bool = true

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: Node2D) -> void:
	health_component.pushback.connect(on_pushback)
	for child in get_children():
		child.parent = parent

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: enemy_state) -> void:
	if current_state:
		current_state.exit()

	current_state = new_state
	label_action.text = current_state.get_name()
	current_state.enter()
	
# Pass through functions for the Player to call,
# handling state changes as needed.
func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func on_pushback():
	call_pushback = true
	
func set_readiness_to_attack(value: bool):
	ready_to_attack = value
