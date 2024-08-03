extends enemy_state
class_name  enemy_chase_state

@export
var fall_state: enemy_state
@export
var idle_state: enemy_state
@export
var patrol_state: enemy_state
@export
var attack_state: enemy_state

func enter() -> void:
	super()
	state_machine.call_chasing = false

func process_frame(delta: float) -> enemy_state:
	return super(delta)
	
func process_physics(delta: float) -> enemy_state:
	if !parent.floating:
		parent.global_position.y += gravity * delta
		
	if state_machine.ready_to_attack and threshold_reached():
		return attack_state
		
	if !parent.floating and !parent.is_on_floor():
		return fall_state
	
	var direction = set_direction_to_chase()
	var movement = parent.chase_speed * delta #* direction
	#parent.global_position = lerp(parent.global_position, parent.playerBody.global_position, movement)
	parent.global_position = parent.global_position + parent.global_position.direction_to(parent.playerBody.global_position) * movement
	parent.sprite_2d.flip_h = set_direction_to_chase() < 0

	return null

func set_direction_to_chase() -> int:
	if parent.playerBody.global_position.x < parent.global_position.x:
		return -1
	else:
		return 1
		
func threshold_reached() -> bool:
	var distance = abs(parent.global_position.distance_to(parent.playerBody.global_position))
	if distance < parent.chase_threshold:
		return true
	return false
