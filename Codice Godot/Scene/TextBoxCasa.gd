extends NinePatchRect

signal dialogue_finished
var space = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	$Label.text = "[Cittadino]:Grazie per essere venuto qui a Celestia.
	 Avevamo bisogno di Hunter in città!  "
	
	if Input.is_action_just_released("ui_accept"):
		space += 1
	match space:
		1:
			$Label.text = "[Cittadino]: Vuoi un piccolo consiglio??"
		2: 
			$Label.text = "[Cittadino]: I mostri fuori dalla città hanno una particolare combinazione di mosse, 
			esse variano in base al luogo... "
		3:
			$Label.text = "[Cittadino]: Però... sshhh...
			Acqua in bocca!"
		4:	
			$Label.text ="[Cittadino]: Questo è il frutto delle mie preziosissime ricerche...
			Miraccomando!!"
			
		5:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			
		


func _on_player_dialogue_npc_1():
	show()
	set_process(true)
	space = 1




