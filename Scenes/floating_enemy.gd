extends enemy
class_name floating_enemy

@onready var animations = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var detectionAreaTimer = $Sprite2D/Collisions/DetectionArea/Timer
@onready var pushback_timer = $PushbackTimer
@onready var state_machine = $StateMachine

var pushback: bool

var speed = 1
var speedPushback = 2

var attackDamage : int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize the state machine, passing a reference of the player to the states,
	# that way they can move and react accordingly
	state_machine.init(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	state_machine.process_frame(delta)
	
func _physics_process(delta):
	state_machine.process_physics(delta)
	
	#if pushback:
		#global_position = global_position - global_position.direction_to(playerBody.global_position) * speedPushback
	#elif chasing:
		#global_position = global_position + global_position.direction_to(playerBody.global_position) * speed


func _on_detection_area_body_entered(body):
	#Detection Area
	playerBody = body
	animations.play("Wakeup")
	detectionAreaTimer.start()
	

func _on_timer_timeout():
	#animation.play("Chase")
	state_machine.call_chasing = true


func _on_killzone_player_death():
	player_death.emit()

func push_back():
	pushback = true
	pushback_timer.start()


func _on_pushback_timer_timeout():
	pushback = false


func _on_body_entered(body):
	damage_player.emit(self, attackDamage)


func _on_collision_to_damage_death():
	queue_free()
