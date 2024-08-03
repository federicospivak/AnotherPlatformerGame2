extends State
class_name AimState

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
@export
var range_attack_state: State

@onready var pivot_aim = %PivotAim

func enter() -> void:
	super()
	pivot_aim.visible = true
	#GlobalVariables.slow_motion(true)

func process_frame(delta: float) -> State:
	return super(delta)
	
func process_input(event: InputEvent) -> State:
	if Input.is_action_just_released("Aim"):
		return idle_state
	if ( Input.is_action_just_pressed('Jump') or parent.forceJump ) and parent.is_on_floor():
		return jump_state
	if Input.is_action_just_pressed('ShootArrow'):
		return range_attack_state
	return null

func process_physics(delta: float) -> State:
	
	print(pivot_aim.rotation_degrees)
	
	
	var aim_movement = Input.get_axis('Aim_up', 'Aim_down') * delta * 3
	print(aim_movement)
	
	if parent.sprite_2d.flip_h == false:
		if pivot_aim.rotation_degrees < 0 and pivot_aim.rotation_degrees > -180:
			pivot_aim.rotation_degrees *= -1
		
		if pivot_aim.rotation_degrees > 0 and pivot_aim.rotation_degrees < 180:
			pivot_aim.rotate(aim_movement)
		elif pivot_aim.rotation_degrees < 0 and aim_movement > 0:
			pivot_aim.rotate(aim_movement)
		elif pivot_aim.rotation_degrees > 180 and aim_movement < 0:
			pivot_aim.rotate(aim_movement)
			
	if parent.sprite_2d.flip_h == true:
		aim_movement *= -1
		
		if pivot_aim.rotation_degrees > 0 and pivot_aim.rotation_degrees < 180:
			pivot_aim.rotation_degrees *= -1
		
		if pivot_aim.rotation_degrees < 0 and pivot_aim.rotation_degrees > -180:
			pivot_aim.rotate(aim_movement)
		elif pivot_aim.rotation_degrees > 0 and aim_movement < 0:
			pivot_aim.rotate(aim_movement)
		elif pivot_aim.rotation_degrees < -180 and aim_movement > 0:
			pivot_aim.rotate(aim_movement)
		
	
	parent.velocity.x = 0
	parent.velocity.y += gravity * delta

	#
	#if movement != 0:
		#parent.sprite_2d.flip_h = movement < 0
	parent.move_and_slide()
		
	return null
	
func exit():
	pivot_aim.visible = false
	#GlobalVariables.slow_motion(false)

