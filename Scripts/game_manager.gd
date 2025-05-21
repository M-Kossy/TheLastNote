extends Node2D

@onready var test: Label = $Test
@onready var static_body_2d_post: StaticBody2D = $TileMap_post/StaticBody2D_post
@onready var static_body_2d_pre: StaticBody2D = $TileMap_pre/StaticBody2D_pre
@onready var tile_map_pre: TileMapLayer = $TileMap_pre
@onready var tile_map_post: TileMapLayer = $TileMap_post
@onready var player = get_tree().get_nodes_in_group("Player")

var stream : AudioStreamSynchronized
var intensity : float = -60
var up_intens : float = 100
var down_intens : float = 20

var is_grabbing:bool = false
var post_war:bool = true
var last_travel: float = Time.get_unix_time_from_system()
var delay: float = 0.2


const TILE_TEXTURES = [
		"res://Sprites/Tiles_sheets_2.png",
		"res://Sprites/Tiles_sheets_2_ok.png"
]


@export var indexMusic : int = 1


var growing = false

func _ready() -> void:
	for i in player:
		i.change_world.connect(switch)
	AudioManager.change_music(indexMusic)
	stream = AudioManager.actual_music.stream
	stream.set_sync_stream_volume(0, 0.0)
	AudioManager.play()


func _physics_process(delta):
	
	var world: int
	
	test.text = str("Post_war: ", post_war)
	
	match post_war:
		true:
			world = 0
			if last_travel + delay < Time.get_unix_time_from_system():
				for i in static_body_2d_pre.get_children():
					i.disabled = true
				for i in static_body_2d_post.get_children():
					i.disabled = false
			
			intensity = clamp(intensity - down_intens * delta, -60, -5)
			
			stream.set_sync_stream_volume(1, intensity)
		false: 
			world = 1
			if last_travel + delay < Time.get_unix_time_from_system():
				for i in static_body_2d_post.get_children():
					i.disabled = true
				for i in static_body_2d_pre.get_children():
					i.disabled = false
			
			intensity = clamp(intensity + up_intens * delta, -60, -5)
			stream.set_sync_stream_volume(1, intensity)


func switch():
	last_travel = Time.get_unix_time_from_system()
	
	if post_war:
		post_war = false
	else:
		post_war = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("RESET"):
		get_tree().reload_current_scene()
