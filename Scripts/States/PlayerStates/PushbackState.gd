extends State
class_name PushbackState
@onready var pushback_timer = $PushbackTimer

@export
var idle_state: State
@export
var fall_state: State

@export
var pushback_speed: int = 50
var pushback_finished: bool

func enter() -> void:
	super()
	state_machine.set_pushback(false)
	pushback_finished = false
	pushback_timer.start()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	
	if pushback_finished:
		pushback_finished = false
		if !parent.is_on_floor():
			return fall_state
		else:
			return idle_state
	
	parent.velocity.y += gravity * delta
	parent.velocity.x = pushback_speed * pushback_direction()

	parent.move_and_slide()
		
	return null
	
func pushback_direction() -> int:
	if state_machine.pushback_direction_right:
		return 1
	else:
		return -1

func _on_pushback_timer_timeout():
	pushback_finished = true
