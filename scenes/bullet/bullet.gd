class_name Bullet

extends Area2D

const MAX_SPEED: int = 400

var direction: Vector2 = Vector2.RIGHT
@onready var notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	notifier.connect("screen_exited", Callable(self, "_on_screen_exited"))

func _process(delta: float):
	global_position += direction * MAX_SPEED * delta


func _on_body_entered(body: Node2D):
	if body.is_in_group("terrain_group"):
		queue_free()


func _on_screen_exited():
	queue_free()
