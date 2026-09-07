extends Node

const SAVE_PATH: String = "user://data.save"
const SAVE_PASSWORD: String = "HiThere!-_-!erehTiH"

var data: Dictionary = {
	"progress": {
		"focus": 0,
		"learning": 1,
		"xp": 0,
		"skills_cost": {
			"programming": 10,
			"art": 10,
			"sound": 10,
			"design": 10,
			"self_discipline": 10,
			"leadership": 10,
			"communication": 10,
			"ethics_and_morals": 10
		}
	}
}


func load_game() -> void:
	_load_data_from_disk()
	_load_level_progress()


func save_game() -> void:
	_save_level_progress()
	_save_data_to_disk()


# --------------------------Filesystem Save/Load----------------------------
func _load_data_from_disk() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		push_warning("No existing save exists")
		return
	
	var save_file: FileAccess = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, SAVE_PASSWORD)
	if save_file == null:
		push_error("Save file decryption failed, or the file is corrupted.")
		return
	
	var json: String = save_file.get_as_text()
	var loaded_data: Dictionary = JSON.parse_string(json)
	
	if loaded_data is Dictionary:
		data = loaded_data
	else:
		push_error("Saved data is not in valid format.")


func _save_data_to_disk() -> void:
	var save_file: FileAccess = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, SAVE_PASSWORD)
	if save_file == null:
		push_error("Saving failed, unable to encrypt.")
		return
	
	var json: String = JSON.stringify(data)
	save_file.store_line(json)
# --------------------------Filesystem Save/Load----------------------------


# --------------------------Ingame Load/Save----------------------------
func _load_level_progress() -> void:
	for skill in get_tree().get_nodes_in_group("skills"):
		var s: Skill = skill
		if data["progress"]["skills_cost"].get(s.skill_id):
			s.cost = data["progress"]["skills_cost"][s.skill_id]
	
	Global.level.focus = data["progress"]["focus"]
	Global.level.learning = data["progress"]["learning"]
	Global.level.xp = data["progress"]["xp"]


func _save_level_progress() -> void:
	for skill in get_tree().get_nodes_in_group("skills"):
		var s: Skill = skill
		if data["progress"]["skills_cost"].get(s.skill_id):
			data["progress"]["skills_cost"][s.skill_id] = s.cost
	
	data["progress"]["focus"] = Global.level.focus
	data["progress"]["learning"] = Global.level.learning
	data["progress"]["xp"] = Global.level.xp
# --------------------------Ingame Load/Save----------------------------
