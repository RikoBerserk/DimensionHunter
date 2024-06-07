extends NinePatchRect

signal dialogue_finished

var i = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "[Prof.ssa Hofstarder]: Benvenuto Ethan! 
	E' un piacere averti qui."
	
	if Input.is_action_just_released("ui_accept"):
		i += 1	
		
	match i:
		1:
			$Label.text = "[Prof.ssa Hofstarder]: Questo è il laboratorio degli hunter 
			dove qui studiamo i mostri."	
		2:
			$Label.text = "[Prof.ssa Hofstarder]: Lascia che ti curi i mostri,
			li vedo molto stanchi..."
		3: 
			$Label.text = "..."
		4:
			$Label.text = "...  ..."
		5:
			$Label.text = "[Prof.ssa Hofstarder]: Ecco fatto!
			Torna a trovarci!"
		6:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
	

func _on_player_dialogue_npc_1():
	show()
	set_process(true)
	i = 0

