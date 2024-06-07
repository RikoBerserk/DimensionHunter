extends NinePatchRect

var i = 1
var scena = "res://main.tscn"

func _ready():
	set_process(true)

func _process(delta):
	
	if Input.is_action_just_released("ui_accept"):
		i += 1	
	match i:
		1:
			$Label.text = "[Generale Roland]:buongiorno un cazzo sacco di merda"
		2:
			$Label.text = "[Generale Roland]:secondon testo"
		3:
			$Label.text = "[Generale Roland]:terzo testo"
		4:
			get_node("generale roland").hide()
		5:
			$Label.text = "[Generale Roland]:terzo testo"
		6:
			$Label.text = "[Generale Roland]:terzo testo"
		7:
			SceneSwitcher.switch_scene(scena, -4714,2090)
	
