class_name Enemy

extends CharacterBody2D

enum Direction {RIGHT, LEFT}

@export var direction: Direction = Direction.RIGHT

const MAX_SPEED: int = 60
const GRAVITY: int = 1000

var movement_vector: Vector2 = Vector2.RIGHT
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	movement_vector = Vector2(1, 0) if direction == Direction.RIGHT else Vector2(-1, 0)

func _physics_process(delta: float):
	if is_on_floor():
		velocity = movement_vector * MAX_SPEED
	else:
		velocity.y += GRAVITY * delta
	
	move_and_slide()


func change_direction():
	movement_vector.x = -movement_vector.x
	animated_sprite.flip_h = movement_vector.x < 0


func _on_hitbox_area_entered(area: Area2D):
	if area is Bullet:
		queue_free()
		area.queue_free()
