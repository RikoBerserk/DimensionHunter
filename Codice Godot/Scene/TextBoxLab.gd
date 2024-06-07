extends NinePatchRect

signal dialogue_finished

var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "[Prof.ssa Hofstarder]!!"
	if Input.is_action_just_released("ui_accept"):
		i += 1	
		
	match i:
		1:
			$Label.text = "scegli un mostro ktm!!"
		2:
			$Label.text = "prova 2222222222!!"
		3:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
	

func _on_player_dialogue_npc_1():
	show()
	set_process(true)
	i = 0








func _on_player_dialogue_npc_2():
	pass # Replace with function body.
