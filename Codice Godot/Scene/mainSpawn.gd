extends Area2D

var battle ="res://main.tscn"

func _on_body_entered(body):
	if "Player" in body.name:
		var x = $"../Player".position.x
		var y = $"../Player".position.y
		SceneSwitcher.switch_scene(battle, -2955, 2383)






