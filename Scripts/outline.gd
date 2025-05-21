extends Sprite2D

@export var line_color := Color.WHITE

var tween_enter : Tween
var tween_exit : Tween
var outlined := false

func _init() -> void:
	outline_alpha(0)

func entered(speed : float = 0.25) -> void:
	if !outlined:
		tween_enter = create_tween()
		tween_enter.tween_method(outline_alpha, line_color.a, 1.0, speed).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_OUT)
		outlined = true


func exited(speed : float = 0.25) -> void:
	if outlined:
		tween_exit = create_tween()
		tween_exit.tween_method(outline_alpha, line_color.a, 0.0, speed).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)
		outlined = false

func visible_outline(v : bool) -> void:
	if(v):
		if tween_exit != null:
			tween_exit.stop()
		entered(0.1)
	else:
		if tween_enter != null:
			tween_enter.stop()
		exited(0.1)

func outline_alpha(value: float) -> void:
	line_color.a = value
	material.set_shader_parameter("line_color", line_color)
