extends NinePatchRect

signal dialogue_finished
var space = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if space == 1:
		$Label.text = "[Ragazzo]: Celestia è una piccola città ma ha tutto il necessario."
	if Input.is_action_just_released("ui_accept"):
		if space == 2 :
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			
		space = 2
		$Label.text = "[[Ragazzo]: Se cerchi il laboratorio della dottoressa Hofstarder è qui vicino.
		Ti aiuterà a rimmettere in sesto i tuoi mostri."
		

func _on_player_dialogue_npc_2():
	show()
	set_process(true)
	space = 1
