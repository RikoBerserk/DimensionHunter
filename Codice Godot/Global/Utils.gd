extends Node

const SAVE_PATH: String = "res://savegame.bin"


func save_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var jstr = JSON.stringify(Game.SelectMonster)
	file.store_line(jstr)
	
func load_game() -> void:
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return
	if file == null:
		return
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			for i in current_line:
				Game.addMonster(current_line[i]["Name"])
				Game.SelectMonster[int(i)]["Level"] = current_line[i]["Level"]
				Game.SelectMonster[int(i)]["Exp"] = current_line[i]["Exp"]
				Game.SelectMonster[int(i)]["MaxExp"] = current_line[i]["MaxExp"]
				Game.SelectMonster[int(i)]["Health"] = current_line[i]["Health"]
				Game.SelectMonster[int(i)]["MaxHealth"] = current_line[i]["MaxHealth"]
				Game.SelectMonster[int(i)]["Strenght"] = current_line[i]["Strenght"]
				
