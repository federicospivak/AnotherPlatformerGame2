extends Node
class_name State_Machine

@export var starting_state: State
@export var pushback_state: State

var current_state: State
@export var label_action = Label

var call_pushback: bool
var pushback_direction_right: bool

# Initialize the state machine by giving each child state a reference to the
# parent object it belongs to and enter the default starting_state.
func init(parent: CharacterBody) -> void:
	for child in get_children():
		child.parent = parent

	# Initialize to the default state
	change_state(starting_state)

# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
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

func set_pushback(mode: bool, right_direction: bool = false):
	call_pushback = mode
	if call_pushback:
		pushback_direction_right = right_direction
