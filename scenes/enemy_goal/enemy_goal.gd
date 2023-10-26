class_name EnemyGoal

extends Area2D


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	

func _on_body_entered(body: Node2D):
	if body is Enemy:
		var enemy: Enemy = body as Enemy
		enemy.change_direction()
	
