extends StaticBody2D

@onready var game_manager: Node2D = $"../../Game_manager"
@onready var platform_sprite: Sprite2D = $PlatformSprite

@export var active_go_up: bool = true
@export var max_height : int = 200
@export var speed_up : int = 200
@export var speed_down : int = 60

@export var cranks: Array[StaticBody2D]

var min_height : int = 0


var direction : int = 0


func _init():
	min_height = position.y

func _ready() -> void:
	for crank in cranks:
		crank.connect("go_up", _on_crank_go_up)
		crank.connect("go_down", _on_crank_go_down)
		


func _process(delta : float) -> void:
	if game_manager.post_war:
		return
	if direction == 0:
		return
	elif direction == 1:
		if active_go_up:
			position.y = clamp(position.y - speed_up*delta, min_height - max_height, min_height)
		else:
			position.y = clamp(position.y + speed_up*delta, min_height, min_height + max_height)
	elif direction == -1:
		if active_go_up:
			position.y = clamp(position.y + speed_down*delta, min_height - max_height, min_height)
		else:
			position.y = clamp(position.y - speed_down*delta, min_height,  min_height + max_height)
		

		
	
func _on_crank_go_up():
	direction = 1 


func _on_crank_go_down():
	direction = -1
