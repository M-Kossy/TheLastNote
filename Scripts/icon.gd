extends Node2D
@onready var icon = $icon

var default_pos : Vector2 = icon.position
var amplitude : float = 1.0
var frequency : float = 1.0
var time := 0


var floated : Vector2 = Vector2.ZERO

func _init():
	icon.visible = false
	
func set_icon_visible(b : bool) -> void:
	icon.visible = b

func _process(delta):
	time += delta * frequency
	icon.position = default_pos + Vector2(0, sin(time) * amplitude)
