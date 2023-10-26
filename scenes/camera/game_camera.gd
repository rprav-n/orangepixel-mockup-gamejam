class_name GameCamera

extends Camera2D


func _ready():
	GameEvent.connect("camera_follow_player", Callable(self, "_on_camera_follow_player"))


func _process(_delta: float):
	pass


func _on_camera_follow_player(player_position: Vector2):
	global_position = lerp(global_position, player_position, 0.2)

