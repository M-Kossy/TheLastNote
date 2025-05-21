extends Node2D


var amplitude: float = 4
var frequency: float = 4
var time: float = 1.0

@export var Photo: Texture2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D


var default_pos = self.get_position()

func _ready() -> void:
	sprite_2d.texture = Photo

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	time += delta * frequency
	
	self.set_position(default_pos + Vector2(0, sin(time) * amplitude))


func _on_area_2d_body_entered(body):
	animation_player.play("Pick_up")
