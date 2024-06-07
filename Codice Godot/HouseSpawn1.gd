extends Area2D

var scena = "res://Scene/House1.tscn"

func _on_body_entered(body):
	if "Player" in body.name:
		var x = $"../Player".position.x
		var y = $"../Player".position.y
		SceneSwitcher.switch_scene(scena,-1, -1)
		

