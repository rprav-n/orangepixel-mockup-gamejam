class_name Main

extends Node

@onready var bullet_scene: PackedScene = preload("res://scenes/bullet/bullet.tscn")

func _ready():
	GameEvent.connect("shoot", Callable(self, "_on_shoot"))


func _on_shoot(spawn_position: Vector2, direction: int):
	if bullet_scene == null:
		return
	
	var bullet: Bullet = bullet_scene.instantiate() as Bullet
	add_child(bullet)
	bullet.direction = Vector2.RIGHT if direction == 1 else Vector2.LEFT
	bullet.global_position = spawn_position

