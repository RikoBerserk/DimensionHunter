extends Node2D

var scena_new = "res://Scene/Intro.tscn"
var scena_load = "res://main.tscn"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_button_pressed():
	Game.addMonster("Meownster")
	SceneSwitcher.switch_scene(scena_new, -4714,2090)


func _on_button_1_pressed():
	Utils.load_game()
	SceneSwitcher.switch_scene(scena_load, -4714,2090)
