extends StaticBody2D

@onready var game_manager: Node2D = $"../../Game_manager"
@onready var icon = $"../Icon"
@onready var crank_sprite_ok: Sprite2D = $crankSprite_ok

@onready var crank_sprite_ok_second: Sprite2D = $crankSprite_ok_second

@export var color_outline : Color = Color.WHITE
@export var plateform_to_follow: StaticBody2D

var player_near : bool = false
var player : CharacterBody2D = null
var isGrabbed : bool = false
var distance: Vector2

signal go_up
signal go_down



func _ready():
	color_outline.a = 0
	crank_sprite_ok.line_color = color_outline
	if plateform_to_follow != null:
		distance = position - plateform_to_follow.position

func _process(delta: float) -> void:
	if plateform_to_follow != null:
		position = distance + plateform_to_follow.position


func _on_area_2d_body_entered(body):
	player_near = true
	player = body
	crank_sprite_ok.entered()
	if game_manager.post_war:
		crank_sprite_ok.visible_outline(false)

func _on_area_2d_body_exited(body):
	player_near = false
	if player != null:
		player.accept_move(true)
		isGrabbed = false
		crank_sprite_ok.exited()
		
		go_down.emit()
		crank_sprite_ok.visible = true
		crank_sprite_ok_second.visible = false
		crank_sprite_ok.visible_outline(false)

func _unhandled_input(event):
	if !player_near:
		return
		
	if game_manager.post_war:
		crank_sprite_ok.visible_outline(false)
	else:
		crank_sprite_ok.visible_outline(true)
	
	if Input.is_action_just_pressed("DRAG") and !isGrabbed and !game_manager.post_war:
		player.accept_move(false)
		go_up.emit()
		isGrabbed = true
		crank_sprite_ok.visible = false
		crank_sprite_ok_second.visible = true
		crank_sprite_ok.visible_outline(false)
		
	elif Input.is_action_just_released("DRAG") and !game_manager.post_war:
		player.accept_move(true)
		isGrabbed = false
		# icon.set_icon_visible(true)
		go_down.emit()
		crank_sprite_ok.visible = true
		crank_sprite_ok_second.visible = false
		crank_sprite_ok.visible_outline(true)
