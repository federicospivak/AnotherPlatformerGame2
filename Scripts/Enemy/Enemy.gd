extends Node2D
class_name enemy

signal player_death
signal damage_player

@onready var playerBody = %CharacterBody2D

@export var move_speed: float = 800
@export var chase_speed : int = 1200
@export var chase_threshold : int = 10
@export var floating : bool = false

@export var pushback_speed: int = 50


func is_on_floor() -> bool:
	return false
