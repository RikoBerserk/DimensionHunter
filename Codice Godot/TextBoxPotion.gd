extends NinePatchRect

signal dialogue_finished
var space = 1
var namePotion = 0
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
			$Label.text = "Congratulazioni! Hai trovato : " + str(namePotion) 
	
		2:
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			


func _on_player_potion():
	var trovato = 0
	var random = randi_range(1,10)
	if random == 10:
		namePotion = "PS-Total"
	elif random >= 1 && random < 6:
		namePotion = "PS-H"
	elif random > 6 && random < 10:
		namePotion = "PS-H2"
	for i in Game.SelectPotion:
		if Game.SelectPotion[i]["Name"] == namePotion && trovato == 0:
			Game.SelectPotion[i]["Amount"] += 1
			trovato = 1
	if trovato == 0:
		if namePotion == "PS-Total":
			Game.addPotion("PS-Total")
		if namePotion == "PS-H":
			Game.addPotion("PS-H")
		if namePotion == "PS-H2":
			Game.addPotion("PS-H2")
		for i in Game.SelectPotion:
			if Game.SelectPotion[i]["Name"] == namePotion:
				Game.SelectPotion[i]["Amount"] += 1
		
	
	
	show()
	set_process(true)
	space = 1
