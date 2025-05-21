extends CharacterBody2D

@onready var sprite_2d = $Sprite2D
@export var color_outline : Color = Color.WHITE
var is_player_inside: bool = false
var player : Node2D
var distance : Vector2 = Vector2.ZERO

func _ready():
	color_outline.a = 0
	sprite_2d.line_color = color_outline
	
	
func _on_area_2d_right_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = true
		player = body
		distance = position - player.position
		sprite_2d.entered()
	
	
	
func _on_area_2d_right_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		is_player_inside = false
		player = null
		sprite_2d.exited()
	
	
	
func _process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if is_player_inside:
		if Input.is_action_pressed("DRAG"):
			position.x = player.position.x + distance.x
			sprite_2d.visible_outline(false)
		else:
			sprite_2d.visible_outline(true)
	move_and_slide()
