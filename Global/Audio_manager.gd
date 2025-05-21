extends Node2D

@onready var lv_1: AudioStreamPlayer = $lv1
@onready var lv_2: AudioStreamPlayer = $lv2
@onready var lv_3: AudioStreamPlayer = $lv3
@onready var lv_4: AudioStreamPlayer = $lv4

@onready var actual_music : AudioStreamPlayer = lv_1
@onready var indexToPlay : int = 1

	
func stop():
	actual_music.stop()

func play():
	if !actual_music.playing:
		actual_music.play()

func change_music(index: int) -> bool:
	if indexToPlay == index:
		return false
	if actual_music != null:
		actual_music.stop()
	if(index == 1):
		actual_music = lv_1
	elif(index == 2):
		actual_music = lv_2
	elif(index == 3):
		actual_music = lv_3
	elif(index == 4):
		actual_music = lv_4
	indexToPlay = index
	return true
