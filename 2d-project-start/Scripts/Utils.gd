extends Node

const SAVE_PATH = "res://Save_Data/savegame.bin"


func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"playerLevel": Game.playerLevel,
		"enemyLevel": Game.enemyLevel,
		"xp": Game.xp,
		"xp_max": Game.xp_max,
		"position": Game.position,
		"minute": Game.minute,
		"seconds": Game.seconds,
		"upgrades": Game.upgrades,
		"inventory": Game.inventory,
	}
	var jstr = JSON.stringify(data, "\t")
	file.store_line(jstr)

func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.playerLevel = current_line["playerLevel"]
				Game.enemyLevel = current_line["enemyLevel"]
				Game.xp = current_line["xp"]
				Game.xp_max = current_line["xp_max"]
				Game.position = current_line["position"]
				Game.minute = current_line["minute"]
				Game.seconds = current_line["seconds"]
				Game.upgrades = current_line["upgrades"]
				Game.inventory = current_line["inventory"]















