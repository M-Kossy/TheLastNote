extends Node2D

@onready var text: Label = $Label

@export var intensity_speed: float = 10
var _visible: bool = false



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_visible = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_visible = false


func _process(delta: float) -> void:
	if _visible:
		text.label_settings.font_color.a = clamp(text.label_settings.font_color.a + intensity_speed *delta, 0.0, 1.0)
	else:
		text.label_settings.font_color.a = clamp(text.label_settings.font_color.a - intensity_speed *delta, 0.0, 1.0)
