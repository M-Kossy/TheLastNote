extends CharacterBody2D

@onready var ladder_destroy: Sprite2D = $Ladder_destroy
@onready var ladder_ok: Sprite2D = $Ladder_ok
@onready var area_2d_ok: Area2D = $Ladder_ok/Area2D_ok
@onready var area_2d_destroy: Area2D = $Ladder_destroy/Area2D_destroy
@onready var game_manager: Node2D = $"../Game_manager"
@onready var legs: CollisionShape2D = $Legs
@onready var audio_stream_player = $AudioStreamPlayer


var delay: float = 0.2
var time_before_fall : float
var is_player_inside: bool = false
var player : Node2D
var signed : int = 1
var decalage : int = 25
var color_outline : Color = Color.WHITE

signal can_climb

var fly: bool = false

func _ready():
	color_outline.a = 0
	ladder_destroy.line_color = color_outline
	
	


func _process(delta):
	var post_war: bool = game_manager.post_war
	
	if post_war == false:
		area_2d_ok.monitoring = true
		area_2d_destroy.monitoring = false
		ladder_destroy.visible_outline(false)
	if post_war == true:
		area_2d_ok.monitoring = false
		area_2d_destroy.monitoring = true
		
	
	if is_player_inside and game_manager.post_war == true:
		if Input.is_action_pressed("DRAG"):
			var distance = position - player.position
			if distance.x > 0:
				signed = 1
			else:
				signed = -1
			position.x = player.position.x + decalage * signed
			ladder_destroy.visible_outline(false)
			player.set_rotate_sprite(false)
		else:
			ladder_destroy.visible_outline(true)
			player.set_rotate_sprite(true)
	
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		if !fly:
			fly = true
			time_before_fall = Time.get_unix_time_from_system() 
	elif is_on_floor() and fly:
		fly = false
		if time_before_fall + delay < Time.get_unix_time_from_system():
			audio_stream_player.play()
		
	move_and_slide()


#Hitbox de l'échelle
func _on_area_2d_destroy_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_climb.emit()
func _on_area_2d_destroy_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_climb.emit()

func _on_area_2d_ok_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_climb.emit()
func _on_area_2d_ok_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_climb.emit()


#Hitbox pour des poignées
func _on_area_2d_body_entered(body: Node2D) -> void:
	is_player_inside = true
	player = body
	ladder_destroy.entered()

func _on_area_2d_body_exited(body: Node2D) -> void:
	is_player_inside = false
	player = null
	ladder_destroy.exited()
	body.set_rotate_sprite(true)
