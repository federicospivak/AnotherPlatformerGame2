extends State
class_name JumpState

@export
var fall_state: State
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

@export
var jump_force: float = 300.0

var prevVelocity: Vector2

func enter() -> void:
	super()
	parent.forceJump = false
	parent.velocity.y = -jump_force

func process_frame(delta: float) -> State:
	return super(delta)

func process_input(event: InputEvent) -> State:
	if GlobalVariables.able_attack:
		if Input.is_action_just_pressed('Attack'):
			return attack_state
		elif Input.is_action_pressed('Aim'):
			return aim_state
	return null

func process_physics(delta: float) -> State:
	if abs(parent.velocity.y) < 100:
		parent.velocity.y += ( gravity - 200 ) * delta
	else:
		parent.velocity.y += gravity * delta
	
	parent.velocity.y = lerp(prevVelocity.y, parent.velocity.y, 0.8)
	
	if Input.is_action_just_released("Jump") and not parent.is_on_floor():
		parent.velocity.y *= 0.4
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if Input.is_action_just_pressed('Jump'):
		if !parent.is_on_floor() and (parent.wall_left.is_colliding() or parent.wall_right.is_colliding()):
			return walljump_state
	
	if movement != 0:
		#parent.animations.flip_h = movement < 0
		parent.sprite_2d.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		if parent.velocity.y > 0:
			if (movement < 0 and parent.is_left_wall_colliding()) or (movement > 0 and parent.is_right_wall_colliding()):
				return slide_state
			else:
				return fall_state	
	else:
		if movement != 0:
			return move_state
		return idle_state
		
	
	prevVelocity = parent.velocity
		
	return null


