extends State
class_name FallState
@onready var ray_cast_2d = %Floor

@export
var idle_state: State
@export
var move_state: State
@export
var walljump_state: State
@export
var slide_state: State
@export
var attack_state: State
@export
var aim_state: State

func process_frame(delta: float) -> State:
	return super(delta)

func process_input(event: InputEvent) -> State:
	if GlobalVariables.able_attack:
		if Input.is_action_just_pressed('Attack'):
			return attack_state
		elif Input.is_action_pressed('Aim'):
			return aim_state
	if Input.is_action_just_pressed('Jump'):
		if parent.wall_left.is_colliding() or parent.wall_right.is_colliding():
			return walljump_state
	return null

func process_physics(delta: float) -> State:
	if abs(parent.velocity.y) < 50:
		parent.velocity.y += ( gravity - 200 ) * delta
	else:
		parent.velocity.y += gravity * delta
		
	if parent.velocity.y > 200:
		parent.velocity.y = 200

	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement != 0:
		#parent.animations.flip_h = movement < 0
		parent.sprite_2d.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	

	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	else:
		if (movement < 0 and parent.is_left_wall_colliding()) or (movement > 0 and parent.is_right_wall_colliding()):
			return slide_state
		if Input.is_action_just_pressed('Jump') and ray_cast_2d.is_colliding():
			parent.forceJump = true;
			print('FORCE_JUMP')
	return null



