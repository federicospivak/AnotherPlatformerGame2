extends enemy_state
class_name enemy_pushback_state
@onready var pushback_timer = $PushbackTimer

@export
var idle_state: enemy_state
@export
var fall_state: enemy_state

var pushback_finished: bool

func enter() -> void:
	super()
	state_machine.call_pushback = false
	pushback_finished = false
	pushback_timer.start()

func process_physics(delta: float) -> enemy_state:
	
	if pushback_finished:
		pushback_finished = false
		if !parent.floating and !parent.is_on_floor():
			return fall_state
		else:
			return idle_state
	
	if !parent.floating:
		parent.global_position.y += gravity * delta
	parent.global_position.x += parent.pushback_speed * pushback_direction()
		
	return null
	
func pushback_direction() -> int:
	if parent.playerBody.global_position.x < parent.global_position.x:
		return 1
	else:
		return -1

func _on_pushback_timer_timeout():
	pushback_finished = true
