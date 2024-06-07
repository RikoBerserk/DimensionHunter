extends Node

var stop = false # usata per bloccare lo spawn del campo di battaglia

func _ready():
	#addMonster("Meownster")
	#addMonster("Brancaterra")
	#addMonster("Bluzilla")
	#addMonster("Petrogolem")
	#addMonster("Ariokh")

	#Utils.load_game()

	print(SelectMonster)

var DataBase = {
	0:{
		"Name" : "Meownster",
		"Health" : 30,
		"MaxHealth" : 30,
		"Level" : 3,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strenght" : 10,
		"Scene" : preload("res://Monster/Meownster.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "attacco1",
				"Target" : "Monster",
				"Category" : "sasso",
				"Damage" : 1.1,
			},
			1 : {
				"Name" : "attacco2",
				"Target" : "Monster",
				"Category" : "carta",
				"Damage" : 1.2,
			},
			2 : {
				"Name" : "attacco3",
				"Target" : "Monster",
				"Category" : "forbice",
				"Damage" : 1.3,
			}
		}
	},
	1:{
		"Name" : "Bluzilla",
		"Health" : 26,
		"MaxHealth" : 26,
		"Level" : 2,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strenght" : 6,
		"Scene" :  preload("res://Monster/Bluzilla.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "attacco1",
				"Target" : "Monster",
				"Category" : "sasso",
				"Damage" : 1.2,
			},
			1 : {
				"Name" : "attacco2",
				"Target" : "Monster",
				"Category" : "carta",
				"Damage" : 1.2,
			},
			2 : {
				"Name" : "attacco3",
				"Target" : "Monster",
				"Category" : "forbice",
				"Damage" : 1.2,
			}
		}
	},
	2:{
		"Name" : "Petrogolem",
		"Health" : 30,
		"MaxHealth" : 28,
		"Level" : 2,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strenght" : 4,
		"Scene" : preload("res://Monster/Petrogolem.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "attacco1",
				"Target" : "Monster",
				"Category" : "sasso",
				"Damage" : 1.1,
			},
			1 : {
				"Name" : "attacco2",
				"Target" : "Monster",
				"Category" : "carta",
				"Damage" : 1.3,
			},
			2 : {
				"Name" : "attacco3",
				"Target" : "Monster",
				"Category" : "forbice",
				"Damage" : 1.2,
			}
		}
	},
	4:{
		"Name" : "Brancaterra",
		"Health" : 22,
		"MaxHealth" : 22,
		"Level" : 2,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strenght" : 10,
		"Scene" : preload("res://Monster/Brancaterra.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "attacco1",
				"Target" : "Monster",
				"Category" : "sasso",
				"Damage" : 1.3,
			},
			1 : {
				"Name" : "attacco2",
				"Target" : "Monster",
				"Category" : "carta",
				"Damage" : 1,
			},
			2 : {
				"Name" : "attacco3",
				"Target" : "Monster",
				"Category" : "forbice",
				"Damage" : 1.3,
			}
		}
	},
	5:{
		"Name" : "Ariokh",
		"Health" : 24,
		"MaxHealth" : 24,
		"Level" : 2,
		"Exp" : 0,
		"MaxExp" : 10,
		"Strenght" : 8,
		"Scene" : preload("res://Monster/Ariokh.tscn"),
		"Attacks" : {
			0 : {
				"Name" : "attacco1",
				"Target" : "Monster",
				"Category" : "sasso",
				"Damage" : 1.3,
			},
			1 : {
				"Name" : "attacco2",
				"Target" : "Monster",
				"Category" : "carta",
				"Damage" : 1.3,
			},
			2 : {
				"Name" : "attacco3",
				"Target" : "Monster",
				"Category" : "forbice",
				"Damage" : 1,
			}
		}
	},
}

var Potion = {
	0:{
		"Name" : "PS-H",
		"Amount" : 0,
		"Power" : "10",
		"Scene" :  preload("res://Pozioni/ps_h.tscn"),
		"Description" : "Aumenta la vita di un mostro di 10 PS",
		"Text" : " aumentata di 10 PS",
	},
	1:{
		"Name" : "PS-H2",
		"Amount" : 0,
		"Power" : "30",
		"Scene" :  preload("res://Pozioni/ps_h2.tscn"),
		"Description" : "Aumenta la vita di un mostro di 30 PS",
		"Text" : " aumentata di 30 PS",
	},
	2:{
		"Name" : "PS-Total",
		"Amount" : 0,
		"Power" : "10000",
		"Scene" :  preload("res://Pozioni/ps_total.tscn"),
		"Description" : "Rigenera completamente la vita di un mostro",
		"Text" : " rigenerata completamente",
	},
}

var SelectMonster = {
	
}

var SelectPotion = {
	
}
func changeStop(valore):
	stop = valore
	
func addMonster(Name):
	for i in DataBase:
		if DataBase[i]["Name"] == Name:
			var temp = DataBase[i].duplicate(true)
			SelectMonster[SelectMonster.size()] = temp
			
func addPotion(Name):
	for i in Potion:
		if Potion[i]["Name"] == Name:
			var temp = Potion[i].duplicate(true)
			SelectPotion[SelectPotion.size()] = temp
			

func addExp(amount, Name):
	for i in SelectMonster:
		if Name == SelectMonster[i]["Name"]:
			SelectMonster[i]["Exp"] += amount 
			if SelectMonster[i]["Exp"] >= SelectMonster[i]["MaxExp"]:
				#livello successivo
				SelectMonster[i]["Level"] += 1
				SelectMonster[i]["Exp"] = 0
				SelectMonster[i]["MaxExp"] = SelectMonster[i]["MaxExp"] * 1.5
				#assegnazione di un valore casuale alla vita e all'attacco ogni volta che si sale di livello
				var health = randi_range(3, 5)
				SelectMonster[i]["MaxHealth"] = SelectMonster[i]["MaxHealth"] + health
				SelectMonster[i]["Health"] = SelectMonster[i]["Health"] + health
				var attacco = randi_range(1, 3)
				SelectMonster[i]["Strenght"] = SelectMonster[i]["Strenght"] + attacco
				
			
