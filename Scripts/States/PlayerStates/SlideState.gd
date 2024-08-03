extends State
class_name SlideState

@export
var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var walljump_state: State

var prevVelocity: Vector2

func enter() -> void:
	super()

	if parent.wall_left.is_colliding():
		#parent.animations.flip_h = false
		parent.sprite_2d.flip_h = false
	else:
		#parent.animations.flip_h = true
		parent.sprite_2d.flip_h = true

func process_frame(delta: float) -> State:
	return super(delta)
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('Jump'):
		return walljump_state
	if (Input.is_action_just_pressed('move_left') and parent.wall_right.is_colliding()) or (Input.is_action_just_pressed('move_right') and parent.wall_left.is_colliding()):
		return move_state
	return null

func process_physics(delta: float) -> State:
	
	if parent.velocity.y > 0:
		parent.velocity.y = 50
	else:
		if abs(parent.velocity.y) < 100:
			parent.velocity.y += ( gravity - 200 ) * delta
		else:
			parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if parent.velocity.y > 0 and (movement == 0 or (!parent.wall_left.is_colliding() and !parent.wall_right.is_colliding())):
		return fall_state
	
	
	#if movement != 0:
		#parent.animations.flip_h = movement < 0

	#parent.velocity.x = lerp(prevVelocity.x, parent.velocity.x, 0.8)
	parent.move_and_slide()
	
	prevVelocity = parent.velocity
	
	if parent.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	
	return null


