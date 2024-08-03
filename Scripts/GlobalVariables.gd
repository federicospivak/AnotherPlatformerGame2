extends Node

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var jumping: bool
var rolling: bool
var able_attack: bool = true
# Same as writing

var player: Player

var freeze_slow := 0.07
var freeze_time := 0.3


func freeze_engine() -> void:
	Engine.time_scale = freeze_slow
	await get_tree().create_timer(freeze_time * freeze_slow).timeout
	Engine.time_scale = 1
	
func slow_motion(value: bool) -> void:
	if value:
		Engine.time_scale = 0.2
	else:
		Engine.time_scale = 1

