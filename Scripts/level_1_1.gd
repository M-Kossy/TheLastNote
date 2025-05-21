extends Node2D

@onready var hercules = $Hercules
@onready var pause_menu: Control = $CanvasLayer/PauseMenu
@onready var audio_stream_player = $AudioStreamPlayer


var speed_volume : float = 20
var min_volume : float = -10

var paused = false


func _process(delta):
	if Input.is_action_just_pressed("PAUSE"):
		pauseMenu()
	
	if paused:
		audio_stream_player.volume_db = clamp(audio_stream_player.volume_db - speed_volume * delta, min_volume, 0.0)
	else:
		audio_stream_player.volume_db = clamp(audio_stream_player.volume_db + speed_volume * delta, min_volume, 0.0)

func pauseMenu():
	if paused:
		pause_menu.hide()
		hercules.set_physics_process(true)
	else:
		pause_menu.show()
		hercules.set_physics_process(false)
	paused = !paused
