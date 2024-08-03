extends enemy_state
class_name  enemy_patrol_state

@export
var fall_state: enemy_state
@export
var idle_state: enemy_state
@export
var attack_state: enemy_state

func process_frame(delta: float) -> enemy_state:
	return super(delta)
	
func process_physics(delta: float) -> enemy_state:
	if !parent.floating:
		parent.global_position.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	parent.global_position.x += movement
	
	if movement == 0:
		return idle_state

	parent.sprite_2d.flip_h = movement < 0
	
	if !parent.is_on_floor():
		return fall_state
	return null


