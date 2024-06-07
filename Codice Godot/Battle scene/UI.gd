extends Control

var scena = "res://Scene/Laboratorio.tscn"

func _ready():
	switchUpdate()
	$HPBar.max_value = Game.SelectMonster[get_parent().selected]["MaxHealth"]

func _on_lotta_pressed():
	$Menu.hide()
	$"Fight/GridContainer/Attack 1".grab_focus()
	$Fight.show()
	$"../Action".text = "Carta, sasso o forbice?"


func _on_back_pressed():
	$Menu.show()
	$Menu/GridContainer/Lotta.grab_focus()
	$Switch.hide()
	$Fight.hide()
	$"../Action".text = "Tocca a te! Scegli la tua prossima mossa"

func _process(_delta):
	$"../Player".position = Vector2(262,322) 

	$HPBar.value = Game.SelectMonster[get_parent().selected]["Health"]
	$Info.text = str(Game.SelectMonster[get_parent().selected]["Name"]) + " LV. " + str(Game.SelectMonster[get_parent().selected]["Level"])
	$HPTxt.text = str(Game.SelectMonster[get_parent().selected]["Health"])
	#Set attack name
	for i in Game.SelectMonster[get_parent().selected]["Attacks"]:
		var path = "Fight/GridContainer/Attack " + str(((i)+1))
		get_node(path).text = Game.SelectMonster[get_parent().selected]["Attacks"][i]["Name"]
	
func _on_cambia_pressed():
	$Menu.hide()
	$"Switch/GridContainer/Monster 1".grab_focus()
	$Switch.show()
	$Fight.hide()
	$"../Action".text = "Scegli il mostro da cambiare"


func _on_scappa_pressed():
	await get_tree().create_timer(1.5).timeout
	get_parent().queue_free()
	get_tree().paused = false
	SceneSwitcher.switch_scene("res://main.tscn",0,0)


func _on_attack_pressed(extra_arg_0):
	if Game.SelectMonster[get_parent().selected]["Attacks"][extra_arg_0]["Target"] == "Monster":
		var sceltaPlayer = Game.SelectMonster[get_parent().selected]["Attacks"][extra_arg_0]["Category"]
		var damagePlayer = Game.SelectMonster[get_parent().selected]["Attacks"][extra_arg_0]["Damage"] * Game.SelectMonster[get_parent().selected]["Strenght"]
		var attack = Game.SelectMonster[get_parent().selected]["Attacks"][extra_arg_0]["Name"]
		get_parent().MonsterTurn(sceltaPlayer, damagePlayer,attack)
		
		
	
func _on_monster_pressed(extra_arg_0):
		if Game.SelectMonster[extra_arg_0]["Health"] > 0:
			get_parent().selected = extra_arg_0
			for i in $"../Player".get_child_count():
				$"../Player".get_child(i).get_node("AnimationPlayer").play_backwards("Spawn")
			var path = "../Player/" + str(Game.SelectMonster[extra_arg_0]["Name"])
			get_node(path).get_node("AnimationPlayer").play("Spawn")
			get_node(path).show()
			$"../Action".text = "Hai cambiato mostro"
			await get_node(path).get_node("AnimationPlayer").animation_finished
			for i in $"../Player".get_child_count():
				$"../Player".get_child(i).hide()
			get_node(path).show()
			switchUpdate()
			
		else: 
			$"../Action".text = "Mostro distrutto"
	
func switchUpdate():
	for i in 6:
		var path = "Switch/GridContainer/Monster " + str((i+1))
		get_node(path).hide()
		print(get_parent().selected)
	for i in Game.SelectMonster:
		if i != get_parent().selected:
			#if Game.SelectMonster[get_parent().selected]["Health"] > 0:
			var path = "Switch/GridContainer/Monster " + str((i+1))
			get_node(path).text = Game.SelectMonster[i]["Name"]
			get_node(path).show()
	
func deathPlayer():
	var monsterko = 0
	$Menu.hide()
	$"../Action".text = "Il tuo mostro è stato sconfitto..."
	await get_tree().create_timer(1).timeout
	for i in Game.SelectMonster:
		if Game.SelectMonster[i]["Health"] > 0:
			get_parent().selected = i
			for j in $"../Player".get_child_count():
				$"../Player".get_child(j).get_node("AnimationPlayer").play_backwards("Spawn")
			var path = "../Player/" + str(Game.SelectMonster[i]["Name"])
			get_node(path).get_node("AnimationPlayer").play("Spawn")
			get_node(path).show()
			$"../Action".text = "Nuovo mostro entrato in combattimento"
			await get_node(path).get_node("AnimationPlayer").animation_finished
			for k in $"../Player".get_child_count():
				$"../Player".get_child(k).hide()
			get_node(path).show()
			switchUpdate()
		else:
			monsterko += 1
		$Menu.show()
		
	if monsterko == Game.SelectMonster.size() :

		$"../Action".text = "Non hai più mostri disponibili..."
		await get_tree().create_timer(1.5).timeout
		$"../Action".text = "La dottoressa Hofstarder si prenderà cura \n dei tuoi mostri"
		await get_tree().create_timer(1.5).timeout
		SceneSwitcher.switch_scene(scena, -1, -1)
		for i in Game.SelectMonster: #resetto i valori originali dell'health
			Game.SelectMonster[i]["Health"] = Game.SelectMonster[i]["MaxHealth"]
	
	
