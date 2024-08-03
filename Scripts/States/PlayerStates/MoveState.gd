extends State
class_name  MoveState

@export
var fall_state: State
@export
var idle_state: State
@export
var jump_state: State
@export
var roll_state: State
@export
var attack_state: State
@export
var aim_state: State

var prevVelocity: Vector2

func process_frame(delta: float) -> State:
	return super(delta)
	
func process_input(event: InputEvent) -> State:
	if ( Input.is_action_just_pressed('Jump') or parent.forceJump ) and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed('Roll'):
		return roll_state
	if GlobalVariables.able_attack:
		if Input.is_action_just_pressed('Attack'):
			return attack_state
		elif Input.is_action_pressed('Aim'):
			return aim_state
	return null
	
	
func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = get_input_axis() * move_speed
	parent.velocity.x = movement
	
	if movement == 0:
		return idle_state
	
	#parent.animations.flip_h = movement < 0
	parent.sprite_2d.flip_h = movement < 0
	
	#var newVel = Vector2(parent.velocity.x + movement, parent.velocity.y)
	#parent.velocity = parent.velocity.lerp(newVel, 0.8)
	
	parent.move_and_slide()
	
	prevVelocity = parent.velocity
	
	if !parent.is_on_floor():
		return fall_state
	return null


func get_input_axis() -> int:
	var input = Input.get_axis('move_left', 'move_right')
	if input > 0:
		return 1
	elif input < 0:
		return -1
	else:
		return 0

