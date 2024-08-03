extends State
class_name AttackState

#@export
#var fall_state: State
@export
var idle_state: State
@export
var move_state: State
@export
var fall_state: State
@export
var jump_state: State
#@export
#var walljump_state: State
#@export
#var slide_state: State

var anim_finished: bool

func enter() -> void:
	super()
	parent.animations.connect("animation_finished", Callable(self, "_on_anim_finished"))

func process_frame(delta: float) -> State:
	return super(delta)
	
func process_input(event: InputEvent) -> State:
	if ( Input.is_action_just_pressed('Jump') or parent.forceJump ) and parent.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if anim_finished:
		anim_finished = false
		
		if !parent.is_on_floor():
			return fall_state
			
		if movement == 0:
			return idle_state
		else:
			return move_state
	
	parent.velocity.y += gravity * delta
	parent.velocity.x = movement
	#parent.animations.flip_h = movement < 0
	
	if movement != 0:
		parent.sprite_2d.flip_h = movement < 0
	parent.move_and_slide()
		
	return null

func _on_anim_finished(anim_name: String):
	anim_finished = true
