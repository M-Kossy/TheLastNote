extends Node2D

@export var masks : Array[PointLight2D]

@export var speed_open : float = 1000
@export var speed_close : float = 2300
@export var max_radius : float = 10000
@export var target : Node

@onready var game_manager: Node2D = $"../Game_manager"

var radius_reduce: float = 0.01

var speed_reduce: float = 0.0025

func _ready() -> void:
	for mask in masks:
		mask.texture_scale = 0.0

func _physics_process(delta):

	if !(game_manager.post_war):
		for mask in masks:
			mask.position = target.position 
			mask.texture_scale = clamp(mask.texture_scale + speed_open  * delta * speed_reduce, 0.0, max_radius * radius_reduce)
	else:
		for mask in masks:
			mask.position = target.position
			mask.texture_scale = clamp(mask.texture_scale - speed_close * delta * speed_reduce, 0.0, max_radius * radius_reduce)
