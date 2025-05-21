extends CharacterBody2D

@onready var body: AnimatedSprite2D = $Body
@onready var hands: AnimatedSprite2D = $Hands
@onready var trumpet: AnimatedSprite2D = $Trumpet
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var addons = get_tree().get_nodes_in_group("addons")
@onready var game_manager: Node2D = $"../Game_manager"
@onready var cpu_particles_2d: CPUParticles2D = $Trumpet/CPUParticles2D
@onready var area_grab = $Area2D



@export var Speed: int = 80
@export var Run_Speed: int = 50


var push_force = 100
var can_climb: bool = false
var can_move: bool = true
var can_rotate_sprite: bool = true

signal change_world


func _ready() -> void:
	for i in addons:
		i.can_climb.connect(climbing)

func set_rotate_sprite(b : bool):
	can_rotate_sprite = b

func _physics_process(delta: float) -> void:
	
	var direction := Input.get_axis("LEFT", "RIGHT")
	var height := Input.get_axis("UP", "DOWN")
	#change la direction des sprites
	
	if can_move:
		if can_rotate_sprite:
			if direction > 0:
				body.flip_h = false
				trumpet.flip_h = false
				hands.flip_h = false
				area_grab.rotation_degrees = 0.0
			elif direction < 0:
				body.flip_h = true
				trumpet.flip_h = true
				hands.flip_h = true
				area_grab.rotation_degrees = 180.0
		
		#gère les mouvements et la gravité
		if direction:
			velocity.x = direction * Speed 
		else:
			velocity.x = move_toward(velocity.x, 0, Speed)
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		#permet de courrir
		if is_on_floor():
			if Input.is_action_pressed("RUN"):
				velocity.x = direction * (Speed + Run_Speed)
		#Gère les animations
			if direction == 0:
				velocity.x = 0
				animation_player.play("Idle")
			else:
				animation_player.play("Run")
		else:
			animation_player.play("Air")
			
		if Input.is_action_just_pressed("TRUMPET"):
			change_world.emit()
			
		#Fait disparaitre/apparaitre la trompette ou les mains
		if game_manager.post_war == true:
			hands.visible = true
			trumpet.visible = false
		else:
			hands.visible = false
			trumpet.visible = true
		
		if can_climb:
			velocity.y = height * Speed
			
	
	move_and_slide()
	

func accept_move(b : bool):
	can_move = b
	if !b:
		animation_player.play("Idle")
		velocity = Vector2.ZERO



func climbing():
	can_climb = !can_climb


func _on_area_2d_body_entered(body : Node2D):
	if body.has_method("_on_area_2d_body_entered"):
		body._on_area_2d_body_entered(self)

func _on_area_2d_body_exited(body : Node2D):
	if body.has_method("_on_area_2d_body_exited"):
		body._on_area_2d_body_exited(self)
