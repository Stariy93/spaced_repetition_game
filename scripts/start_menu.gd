extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_button_pressed() -> void:
	WordDictionary.word_dictionary = {}
	WordDictionary.save_dictionary()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_load_game_button_pressed() -> void:
	WordDictionary.load_words_dictionary()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_exit_game_button_pressed() -> void:
	get_tree().quit()
