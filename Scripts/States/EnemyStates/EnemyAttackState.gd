extends enemy_state
class_name  enemy_attack_state

@export
var fall_state: enemy_state
@export
var idle_state: enemy_state

@onready var wait_after_attack_timer = $WaitAfterAttackTimer

var attacking: bool


func enter() -> void:
	super()
	state_machine.set_readiness_to_attack(false)
	parent.animations.animation_finished.connect(_on_anim_finished)
	attacking = true

func process_frame(delta: float) -> enemy_state:
	return super(delta)
	
func process_physics(delta: float) -> enemy_state:
	if !parent.floating:
		parent.global_position.y += gravity * delta

	if !parent.floating and !parent.is_on_floor():
		return fall_state
	
	if attacking == false:
		wait_after_attack_timer.start()
		return idle_state
		
	return null

func _on_anim_finished(anim_name: String):
	attacking = false
	parent.animations.animation_finished.disconnect(_on_anim_finished)

func _on_wait_after_attack_timer_timeout():
	state_machine.set_readiness_to_attack(true)
