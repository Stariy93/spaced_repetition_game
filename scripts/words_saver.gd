extends Node

const WORDS_SAVE_PATH := "user://words.json"
const INVENTORY := "user://inventory.json"
var word_dictionary: Dictionary = {}
var player_stats_dictionary: Dictionary = {"hp": 100, "damage": [1, 5]}
var inventory: Dictionary = create_inventory_slots()
	
func load_dict(dict: Dictionary, save_path: String) -> void:
	if not FileAccess.file_exists(save_path):
		word_dictionary = {}
		save_dict(dict, save_path)
		return
		
	var file := FileAccess.open(save_path, FileAccess.READ)
	var json_text := file.get_as_text()
	var json := JSON.new()
	var error := json.parse(json_text)
	
	if error != OK:
		word_dictionary = {}
		return
	
	word_dictionary = json.data
		

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
	
	
func create_inventory_slots() -> Dictionary:
	var dict: Dictionary = {"equiped_items": {"armor_slot": {}, "weapon_slot": {}}, "items": {}}
	for i in range(9):
		dict["items"]["slot" + str(i)] = ""
	return dict
	





	
