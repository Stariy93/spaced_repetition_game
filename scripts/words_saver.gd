extends Node

const WORDS_SAVE_PATH := "user://words.json"
const INVENTORY := "user://inventory.json"
var word_dictionary: Dictionary = load_dict(WORDS_SAVE_PATH)
var inventory_dict: Dictionary = load_dict(INVENTORY)
var player_stats_dictionary: Dictionary = {"hp": 100, "damage": [1, 5]}

	
func load_dict(save_path: String, default_data: Dictionary = {}) -> Dictionary:
	if not FileAccess.file_exists(save_path):
		save_dict(default_data, save_path)
		return default_data.duplicate(true)

	var file := FileAccess.open(save_path, FileAccess.READ)
	if file == null:
		return default_data.duplicate(true)

	var json := JSON.new()
	var error := json.parse(file.get_as_text())
	if error != OK or typeof(json.data) != TYPE_DICTIONARY:
		return default_data.duplicate(true)

	return json.data
		

func save_dict(dict: Dictionary, save_path: String) -> void:
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(dict))
	
	
func remove_dict_element(dict: Dictionary, save_path: String, word_key) -> void:
	dict.erase(word_key)
	save_dict(dict, save_path)
	
	
func change_dict_key(dict: Dictionary, save_path: String, old_key, new_key, new_value) -> void:
	dict.erase(old_key)
	dict[new_key] = new_value
	save_dict(dict, save_path)
	

	





	
