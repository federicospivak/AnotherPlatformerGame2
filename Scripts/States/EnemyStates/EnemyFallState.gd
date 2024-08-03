extends enemy_state
class_name enemy_fall_state

@export
var idle_state: enemy_state
@export
var patrol_state: enemy_state
@export
var chase_state: enemy_state
@export
var attack_state: enemy_state

func process_frame(delta: float) -> enemy_state:
	return super(delta)

func process_physics(delta: float) -> enemy_state:
	#if !parent.floating:
		#if abs(parent.linear_velocity.y) < 50:
			#parent.linear_velocity.y += ( gravity - 200 ) * delta
		#else:
			#parent.linear_velocity.y += gravity * delta
			#
		#if parent.linear_velocity.y > 200:
			#parent.linear_velocity.y = 200
	
	return null



