extends Node2D

var PotionCorrent = 0   #valore della pozione corrente
var indexPotioncorrent = 0  #indice cprrente della pozione selezionata

func _ready():
	$Monster_screen.hide()
	$Use.hide()
	

func _process(delta):
	for i in Game.SelectPotion:
		var monTemp = Game.SelectPotion[i]["Scene"].instantiate()
		monTemp.name = Game.SelectPotion[i]["Name"]
		var pathM = "Potion " + str(((i)+1))
		get_node(pathM).add_child(monTemp)
		var pathI = "Info " + str(((i)+1))
		get_node(pathI).text = str(Game.SelectPotion[i]["Name"]) 
		get_node(pathI).show()
		var pathHP = "Q " + str(((i)+1))
		get_node(pathHP).text = str(Game.SelectPotion[i]["Amount"])
		get_node(pathHP).show()
	
func _on_button_pressed(extra_arg_0):
	if extra_arg_0 in Game.SelectPotion:
		PotionCorrent = Game.SelectPotion[extra_arg_0]["Power"]
		indexPotioncorrent = extra_arg_0
		$TextIntro/Label.text = "               " + Game.SelectPotion[extra_arg_0]["Name"] + "\n" + Game.SelectPotion[extra_arg_0]["Description"]
		$Use.show()
		$Monster_screen.hide()

func use_button_pressed():
	$Monster_screen.show()
	$Back.show()
	$Use.hide()
	$"Monster_screen/VBoxContainer/ButtonMonster 1/LabelMonster 1"
	for i in Game.SelectMonster:
		var monTemp = Game.SelectMonster[i]["Scene"].instantiate()
		monTemp.name = Game.SelectMonster[i]["Name"]
		var pathI = "Monster_screen/VBoxContainer/ButtonMonster " + str(((i)+1)) +"/LabelMonster " + str(((i)+1))
		get_node(pathI).text = str(Game.SelectMonster[i]["Name"])
		get_node(pathI).show()
		
	

func back_button_pressed():
	$Monster_screen.hide()
	$Use.show()
	$Back.hide()




func _on_button_monster_pressed(extra_arg_0):
	Game.SelectMonster[extra_arg_0]["Health"] = Game.SelectMonster[extra_arg_0]["Health"] + int(PotionCorrent)
	if Game.SelectMonster[extra_arg_0]["Health"] > Game.SelectMonster[extra_arg_0]["MaxHealth"]:
		Game.SelectMonster[extra_arg_0]["Health"] = Game.SelectMonster[extra_arg_0]["MaxHealth"]
	$TextIntro/Label.text = "Vita di " + Game.SelectMonster[extra_arg_0]["Name"] + Game.SelectPotion[indexPotioncorrent]["Text"] 
	Game.SelectPotion[indexPotioncorrent]["Amount"] -= 1
	if Game.SelectPotion[indexPotioncorrent]["Amount"] == 0:
		Game.SelectPotion.erase(indexPotioncorrent)
	await get_tree().create_timer(1).timeout
	$TextIntro/Label.text = ""
	get_parent().unload_screen()


	
	
	
	
	
	
	
	
