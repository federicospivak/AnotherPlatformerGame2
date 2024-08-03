extends GPUParticles2D

@export var life_time: float

# Called when the node enters the scene tree for the first time.
func _ready():
	if life_time != null:
		var timer = get_tree().create_timer(life_time)
		timer.connect("timeout", Callable(self, "_on_timeout"))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timeout():
	queue_free()
