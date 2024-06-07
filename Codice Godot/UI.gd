extends Control


func _on_lotta_pressed():
	$Menu.hide()
	$"FightMenu/GridContainer/Attack 1".grab_focus()
	$FightMenu.show()


func _on_back_pressed():
	$Menu.show()
	$Menu/GridContainer/Lotta.grab_focus()
	$SwitchMenu.hide()
	$FightMenu.hide()
	
func _process(_delta):
	$HPBar.value = Game.SelectMonster[get_parent().selected]["Health"]
	$Info.text = str(Game.SelectMonster[get_parent().selected]["Name"]) + "LV." + str(Game.SelectMonster[get_parent().selected]["Level"]) 
	$HpTxt.text = str(Game.SelectMonster[get_parent().selected]["Health"])
	#Set attack name
	for i in Game.SelectMonster[get_parent().selected]["Attacks"]:
		var path = "FightMenu/GridContainer/Attack " + str(((i)+1))
		get_node(path).text = Game.SelectMonster[get_parent().selected]["Attacks"][i]["Name"]
	
	

func _on_cambia_pressed():
	$Menu.hide()
	$"SwitchMenu/GridContainer/Monster1".grab_focus()
	$SwitchMenu.show()
	$FightMenu.hide()

func _on_scappa_pressed():
	$"../UI/AnimationPlayer".play("Transition")
	await get_tree().create_timer(1.5).timeout
	get_parent().queue_free()
	get_tree().paused = false
