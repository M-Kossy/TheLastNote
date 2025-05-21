extends Area2D

@export var Next_level_path = "res://Levels/level_1.tscn"
@onready var stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file(Next_level_path)
