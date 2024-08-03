extends RigidBody2D
class_name Arrow

@export var speed := 400.0
@export var lifetime := 3.0

var direction := Vector2.ZERO
const particleScene := preload("res://Scenes/Particles/particle_explosion_wall.tscn")

@onready var hit_box = $HitBox
@onready var impact_detector = $ImpactDetector
@onready var timer = $Timer
@onready var gpu_particles_2d = $GPUParticles2D
@onready var sprite_2d = $Sprite2D




# Called when the node enters the scene tree for the first time.
func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	#timer.connect("timeout", Callable(self, "queue_free"))
	#timer.start(lifetime)
	#impact_detector.connect("area_entered", Callable(self, "_on_impact"))
	#impact_detector.connect("body_entered", Callable(self, "_on_impact"))
	hit_box.connect("area_entered", Callable(self, "_on_hitbox"))
	direction += direction * speed
	self.apply_impulse(direction)

func _process(delta):
	pass

func _physics_process(delta: float) -> void:
	look_at(position + linear_velocity.normalized())
	#linear_velocity += Vector2(0,1) * delta
	
	
	
func _on_impact(_area: Node) -> void:
	pass
	#queue_free()

func _on_hitbox(_area: Node) -> void:
	_area.health.damage(hit_box.damage)


func _on_impact_detector_area_entered(area):
	pass
	#queue_free()


func _on_impact_detector_body_entered(body):
	#sprite_2d.visible = false
	
	var instance = particleScene.instantiate()
	get_tree().root.add_child(instance)
	instance.global_position = global_position
	instance.emitting = true
	queue_free()


func _on_body_entered(body):
	pass
	#queue_free()
