class_name Player

extends CharacterBody2D

const MAX_HORIZONTAL_SPEED: int = 150
const HORIZONTAL_ACCELERATION: int = 2000
const GRAVITY: int = 1000
const JUMP_SPEED: int = 340
const JUMP_TERMINATION_MULTIPLIER: int = 3


@onready var animated_sprite: AnimatedSprite2D = $Node2D/AnimatedSprite2D
@onready var sprite: Sprite2D = $Node2D/Sprite2D
@onready var marker: Marker2D = $Node2D/Sprite2D/Marker2D
@onready var node: Node2D = $Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	pass
	

func _physics_process(delta: float):
	var movement_vector: Vector2 = get_movement_vector()
	
	velocity.x += movement_vector.x * HORIZONTAL_ACCELERATION * delta
	if movement_vector.x == 0:
		velocity.x = lerp(0.0, velocity.x, pow(2, -50 * delta)) # framerate indepedent lerp
	
	velocity.x = clamp(velocity.x, -MAX_HORIZONTAL_SPEED, MAX_HORIZONTAL_SPEED)
	
	if movement_vector.y < 0 && is_on_floor():
		velocity.y = movement_vector.y * JUMP_SPEED
	
	if velocity.y < 0 && !Input.is_action_pressed("jump"):
		velocity.y += GRAVITY * JUMP_TERMINATION_MULTIPLIER * delta
	else:
		velocity.y += GRAVITY * delta
	
	move_and_slide()
	shoot_bullet()
	update_animation(movement_vector)
	

func get_movement_vector() -> Vector2:
	var movement_vector: Vector2 = Vector2.ZERO
	movement_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	movement_vector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return movement_vector
	

func update_animation(movement_vector: Vector2):
	if movement_vector.x != 0:
		animated_sprite.play("walk")
		node.scale.x = 1 if movement_vector.x > 0 else -1
	else:
		animated_sprite.play("idle")
	
	if velocity.y != 0:
		animated_sprite.play("jump")
		if velocity.y < 0:
			animated_sprite.frame = 0
		else:
			animated_sprite.frame = 0 # Change to 1 if falling animation is needed


func shoot_bullet():
	if Input.is_action_just_pressed("shoot"):
		animation_player.play("recoil")
		var direction: int = int(node.scale.x)
		GameEvent.emit_signal("shoot", marker.global_position, direction)

