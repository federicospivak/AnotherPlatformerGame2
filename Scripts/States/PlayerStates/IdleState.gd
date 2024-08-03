extends State
class_name  IdleState

@export
var fall_state: State
@export
var jump_state: State
@export
var move_state: State
@export
var roll_state: State
@export
var attack_state: State
@export
var aim_state: State

func enter() -> void:
	super()
	parent.velocity.x = 0
	
func process_frame(delta: float) -> State:
	return super(delta)

func process_input(event: InputEvent) -> State:
	if ( Input.is_action_just_pressed('Jump') or parent.forceJump ) and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed('move_left') or Input.is_action_just_pressed('move_right'):
		return move_state
	if Input.is_action_just_pressed('Roll'):
		return roll_state
	if GlobalVariables.able_attack:
		if Input.is_action_just_pressed('Attack'):
			return attack_state
		elif Input.is_action_pressed('Aim'):
			return aim_state
	return null

func process_physics(delta: float) -> State:
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return move_state
		
	
	parent.velocity.y += gravity * delta
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	return null


