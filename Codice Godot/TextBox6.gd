extends NinePatchRect

signal dialogue_finished
var space = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_released("ui_accept"):
		space += 1
	match space:
		1:
			$Label.text = "[Cittadino]: Accidenti !
			Quel maledetto generale ha sconfitto anche me.
			Deve stare da queste parti..."
	
		2:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			

func _on_player_dialogue_npc_6():
	show()
	set_process(true)
	space = 1
