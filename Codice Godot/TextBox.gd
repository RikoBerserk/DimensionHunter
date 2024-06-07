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
			$Label.text = "[Cittadino]: Benvenuto a Celestia!
			Tu devi essere la nuova reclute di cui tutti stanno parlando?
			Si dev'essere così..."
		2: 
			$Label.text = "[Cittadino]: Da quando qui si è instanziato il generale del Genesis Mundi, la vita di questo
			piccolo villaggio sta cambiando in peggio.
			Bisogna cacciarlo!
			Confidiamo tutti in te "
		3:
			$Label.text = "[Cittadino]: Attento quando esci fuori città!
			Si nascondono dei mostri pericolosi.
			Fai attenzione!!"
		4:			
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			
		
	

func _on_player_dialogue_npc_1():
	
	show()
	set_process(true)
	space = 1
