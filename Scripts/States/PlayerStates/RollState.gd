extends State
class_name RollState

@export
var idle_state: State
@export
var move_state: State
@export
var jump_state: State
@export
var fall_state: State

var direction: int
var prevVelocity: Vector2
var anim_finished: bool

func process_frame(delta: float) -> State:
	return super(delta)

func process_input(event: InputEvent) -> State:
	if ( Input.is_action_just_pressed('Jump') or parent.forceJump ) and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed('move_left') or Input.is_action_just_pressed('move_right'):
		return move_state
	return null
	

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta	
	
	if anim_finished:
		anim_finished = false
		if Input.get_axis("move_left", "move_right"):
			return move_state
		else:
			return idle_state
	if !parent.is_on_floor():
		return fall_state

	#if parent.animations.flip_h:
	if parent.sprite_2d.flip_h:
		direction = -1
	else:
		direction = 1
	parent.velocity.x = direction * 180
	parent.velocity.x = lerp(prevVelocity.x, parent.velocity.x, 0.8)
	parent.move_and_slide()
	
	prevVelocity = parent.velocity
	
	return null


func _on_animated_sprite_2d_animation_changed():
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	anim_finished= true
