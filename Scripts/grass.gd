extends Sprite2D
var shader : ShaderMaterial
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	shader = self.material


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	shader.set_shader_parameter("activate_movement", true)
	timer.start()


func _on_timer_timeout():
	shader.set_shader_parameter("activate_movement", false)
