extends State
class_name WallJumpState

@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var slide_state: State

@export
var jump_force: Vector2

var prevVelocity: Vector2

func enter() -> void:
	super()

	parent.forceJump = false
	parent.velocity = -jump_force
	
	if parent.wall_left.is_colliding():
		parent.velocity.x *= -1
		parent.sprite_2d.flip_h = false
	else:
		parent.sprite_2d.flip_h = true
		
func process_frame(delta: float) -> State:
	return super(delta)
	
func process_physics(delta: float) -> State:
	
	if abs(parent.velocity.y) < 50:
		parent.velocity.y += ( gravity - 200 ) * delta
	else:
		parent.velocity.y += gravity * delta
	
	parent.velocity.y = lerp(prevVelocity.y, parent.velocity.y, 0.8)
	
	if Input.is_action_just_released("Jump") and not parent.is_on_floor():
		parent.velocity.y *= 0.4
	
	if parent.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	if movement != 0:
		parent.velocity.x = lerp(movement, parent.velocity.x, 0.8)
		
	parent.move_and_slide()
	
	prevVelocity = parent.velocity
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	else:
		if movement < 0 and parent.wall_left.is_colliding() or movement > 0 and parent.wall_right.is_colliding():
			return slide_state
	
	return null
