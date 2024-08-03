extends Node2D

@export var nextScene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	for torch: torch in get_tree().get_nodes_in_group("torches"):
		torch.light_entered.connect(on_light_entered)
		torch.light_exit.connect(on_light_exit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_finish_body_entered(body):
	var levelNum = str(int(get_tree().current_scene.name.substr(4))+1)
	var next_level_resource = load("res://Scenes/level"+levelNum+".tscn")
	get_tree().change_scene_to_packed(next_level_resource)


func on_light_entered(enemyArea:Node2D):
	print(enemyArea)
	var enemy:floating_enemy
	enemy = enemyArea.get_parent()
	enemy.animations.set_self_modulate(Color(0.2,0.2,0.2,1))
	enemy.speed = 0.4
	
func on_light_exit(enemyArea:Node2D):
	var enemy:floating_enemy
	enemy = enemyArea.get_parent()
	enemy.animations.set_self_modulate(Color(1,1,1,1))
	enemy.speed = 1
