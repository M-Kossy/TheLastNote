extends CanvasLayer

@onready var hercules: CharacterBody2D = $"../Hercules"

var pause = false
var speed_volume : float = 20
var min_volume : float = -10

func pause_unpause():
	pause = !pause
	
	if pause:
		hercules.set_physics_process(false)
		show()
	else:
		hercules.set_physics_process(true)
		hide()

func _input(event):
	if event.is_action_pressed("PAUSE"):
		pause_unpause()
	

func _process(delta):
	
	if AudioManager.actual_music == null:
		return
	
	if pause:
		AudioManager.actual_music.volume_db = clamp(AudioManager.actual_music.volume_db - speed_volume * delta, min_volume, -5)
	else:
		AudioManager.actual_music.volume_db = clamp(AudioManager.actual_music.volume_db + speed_volume * delta, min_volume, -5)
