extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


# Create a new empty dictionary for storing word pairs, save it and move to
# main menu
func _on_new_game_button_pressed() -> void:
	WordDictionary.word_dictionary = {}
	WordDictionary.save_dictionary()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


# Load word pairs dictionary from json file and open main menu
func _on_load_game_button_pressed() -> void:
	WordDictionary.load_words_dictionary()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


# Exit the app
func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
