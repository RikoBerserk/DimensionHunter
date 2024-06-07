extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in Game.SelectMonster:
		var monTemp = Game.SelectMonster[i]["Scene"].instantiate()
		monTemp.name = Game.SelectMonster[i]["Name"]
		var pathM = "Monster " + str(((i)+1))
		get_node(pathM).add_child(monTemp)
		get_node(pathM).scale.x = 0.6
		get_node(pathM).scale.y = 0.6
		var pathI = "Info " + str(((i)+1))
		get_node(pathI).text = str(Game.SelectMonster[i]["Name"]) + " LV. " + str(Game.SelectMonster[i]["Level"])
		get_node(pathI).show()
		var pathHP = "HPBar " + str(((i)+1))
		get_node(pathHP).max_value = Game.SelectMonster[i]["MaxHealth"]
		get_node(pathHP).value = Game.SelectMonster[i]["Health"]
		get_node(pathHP).show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed(extra_arg_0):

		var sasso = Game.SelectMonster[extra_arg_0]["Strenght"]*Game.SelectMonster[extra_arg_0]["Attacks"][0]["Damage"]
		var carta =  Game.SelectMonster[extra_arg_0]["Strenght"]*Game.SelectMonster[extra_arg_0]["Attacks"][1]["Damage"]
		var forbice = Game.SelectMonster[extra_arg_0]["Strenght"]*Game.SelectMonster[extra_arg_0]["Attacks"][2]["Damage"]
		$TextIntro/Label.text =" ATTACCO" + "\n Sasso: " + str(sasso) + "\n Carta: " + str(carta) + "\n Forbice: " + str(forbice)  
		$TextIntro/Label2.text = " DIFESA :\n " + str(Game.SelectMonster[extra_arg_0]["MaxHealth"]) + " PS"
