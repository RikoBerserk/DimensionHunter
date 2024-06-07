extends NinePatchRect

signal dialogue_finished

var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "[Dr. Clarke]: Salve, io sono dottoressa Clarke, 
	lavoro con la prof.ssa Hofstarder per studiare queste creatture."
	if Input.is_action_just_released("ui_accept"):
		i += 1	
		
	match i:
		1:
			$Label.text = "[Dr. Clarke]: Si dice che queste creature provengano da un altra dimensione
			ma tutt'oggi non siamo riusciti a capirne le loro provenienza."
		2:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
	

func _on_player_dialogue_npc_2():
	show()
	set_process(true)
	i = 0

