extends Node2D

var stream: AudioStreamSynchronized

func _ready() -> void:
	AudioManager.change_music(4)
	stream = AudioManager.actual_music.stream
	stream.set_sync_stream_volume(0, 0.0)
	AudioManager.play()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Levels/Intro.tscn")
