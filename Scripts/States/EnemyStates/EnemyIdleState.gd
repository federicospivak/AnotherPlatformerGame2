extends enemy_state
class_name  enemy_idle_state

@export
var fall_state: enemy_state
@export
var patrol_state: enemy_state
@export
var chase_state: enemy_state
@export
var attack_state: enemy_state

func enter() -> void:
	super()
	
func process_frame(delta: float) -> enemy_state:
	var force_state = super(delta)
	if force_state:
		return force_state
	
	if state_machine.call_chasing:
		return chase_state
		
	return null

func process_physics(delta: float) -> enemy_state:
	if !parent.floating:
		parent.global_position.y += gravity * delta
	
	if !parent.floating and !parent.is_on_floor():
		return fall_state
	return null


