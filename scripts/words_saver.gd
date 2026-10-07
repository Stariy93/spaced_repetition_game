extends Node

const WORDS_SAVE_PATH := "user://words.json"
var word_dictionary: Dictionary = {}
	
func load_words_dictionary() -> void:
	if not FileAccess.file_exists(WORDS_SAVE_PATH):
		word_dictionary = {}
		save_dictionary()
		return
		
	var file := FileAccess.open(WORDS_SAVE_PATH, FileAccess.READ)
	var json_text := file.get_as_text()
	var json := JSON.new()
	var error := json.parse(json_text)
	
	if error != OK:
		word_dictionary = {}
		return
	
	word_dictionary = json.data
		

func save_dictionary() -> void:
	var file := FileAccess.open(WORDS_SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(word_dictionary))
	
	
func remove_word(word_key) -> void:
	word_dictionary.erase(word_key)
	save_dictionary()
	
	
func change_word_key(old_key, new_key, new_value) -> void:
	word_dictionary.erase(old_key)
	word_dictionary[new_key] = new_value
	save_dictionary()
	





	
