extends Area2D

var battle ="res://Battle scene/battle.tscn"


func _on_body_entered(body):
	if "Player" in body.name:
		var time = randi_range(2,7)
		await get_tree().create_timer(time).timeout
		if Game.stop == false:
			$"../UI/AnimationPlayer".play("transitionIn")
			await get_tree().create_timer(1.5).timeout
			var x = $"../Player".position.x
			var y = $"../Player".position.y
			SceneSwitcher.switch_scene(battle, x, y)
			queue_free()
			$"../UI/AnimationPlayer".play("transitionOut")
