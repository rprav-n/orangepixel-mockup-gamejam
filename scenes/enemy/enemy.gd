class_name Enemy

extends CharacterBody2D

enum Direction {RIGHT, LEFT}

@export var direction: Direction = Direction.RIGHT

const MAX_SPEED: int = 60
const GRAVITY: int = 1000


var movement_vector: Vector2 = Vector2.RIGHT

func _ready():
	movement_vector = Vector2(1, 0) if direction == Direction.RIGHT else Vector2(-1, 0)

func _physics_process(delta: float):
	if is_on_floor():
		velocity = movement_vector * MAX_SPEED
	else:
		velocity.y += GRAVITY * delta
	
	move_and_slide()
