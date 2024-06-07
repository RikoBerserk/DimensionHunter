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
			$Label.text = "[Cittadino]: Attenzione lì fuori...
			Si nascondono tanto pericoli.
			Lascia che ti dia un consiglio...."
		2:
			$Label.text = "[Cittadino]: Ogni volta che aumenta il livello di un mostro, 
			aumenta sia la sua vita che il suo attacco.
			E ricorda le statistiche di ogni mostro variano in base alla sua specie..."
		3:
			$Label.text = "[Cittadino]: Mmm...
			Il tuo Meownster sembra molto equilibrato."
		4:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			
		
		

func _on_player_dialogue_npc_4():
	show()
	set_process(true)
	space = 1
