extends CanvasLayer
@onready var player_health_bar = $PlayerHealthBar

@export var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player_health_bar.max_value = player.health.max_health
	player_health_bar.value = player_health_bar.max_value
	player.health.health_changed.connect(_on_player_player_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_player_health_changed(health:int):
	player_health_bar.value = health
