extends Node

@onready var music = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	get_node("Player").position = Vector2(-4714,2090)






