extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@export var color_outline : Color = Color.WHITE
@onready var audio_stream_player = $AudioStreamPlayer

var fly: float = false
var delay: float = 0.2
var time_before_fall : float

var is_player_inside: bool = false
var player : Node2D
var distance : Vector2 = Vector2.ZERO
var signed : int = 1


func _ready():
	color_outline.a = 0
	sprite_2d.line_color = color_outline
	
func _on_area_2d_body_entered(body: Node2D):
	is_player_inside = true
	player = body
	distance = position - player.position
	sprite_2d.entered()
	distance = position - player.position
	if distance.x > 0:
		signed = 1
	else:
		signed = -1
	distance.x = abs(distance.x) - 5


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player_inside = false
	player = null
	sprite_2d.exited()
	body.set_rotate_sprite(true)



func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		if !fly:
			fly = true
			time_before_fall = Time.get_unix_time_from_system() 
	elif is_on_floor() and fly:
		fly = false
		if time_before_fall + delay < Time.get_unix_time_from_system():
			audio_stream_player.play()
	if is_player_inside:
		if Input.is_action_pressed("DRAG"):
			position.x = player.position.x + distance.x * signed
			sprite_2d.visible_outline(false)
			player.set_rotate_sprite(false)
		else:
			sprite_2d.visible_outline(true)
			player.set_rotate_sprite(true)
	move_and_slide()
