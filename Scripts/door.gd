extends Node2D

@onready var sprite_ok: Sprite2D = $Sprite_ok
@onready var collision_shape_2d: CollisionShape2D = $Sprite_ok/StaticBody2D/CollisionShape2D
@onready var game_manager: Node2D = $"../Game_manager"


func _physics_process(delta: float) -> void:
	if game_manager.post_war == true:
		collision_shape_2d.disabled = true
	else:
		collision_shape_2d.disabled = false
