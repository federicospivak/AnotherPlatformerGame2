extends CharacterBody2D
class_name CharacterBody

#@onready
#var animations = %AnimatedSprite2D
@onready
var state_machine = %StateMachine
@onready var animations = $AnimationPlayer
@onready var sprite_2d = $Sprite2D

var forceJump: bool = false
@onready var floor = %Floor
@onready var wall_right = %WallRight
@onready var wall_left = %WallLeft
@onready var wall_right_2 = %WallRight2
@onready var wall_left_2 = %WallLeft2


func _ready() -> void:
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	
func is_left_wall_colliding() -> bool:
	print("first left: "+str(wall_left.is_colliding()))
	print("2nd left: "+str(wall_left_2.is_colliding()))
	return wall_left.is_colliding() and wall_left_2.is_colliding()
	
func is_right_wall_colliding() -> bool:
	print("first right: "+str(wall_right.is_colliding()))
	print("2nd right: "+str(wall_right_2.is_colliding()))
	return wall_right.is_colliding() and wall_right_2.is_colliding()


