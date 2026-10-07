extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(WordDictionary.word_dictionary)


#Go to menu where we can add a new word
func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/word_addition_menu.tscn")


#Go to start menu 
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")


#Go to menu were we can edit the words that we allready have
func _on_edit_words_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/words_edition_menu.tscn")


#Move to the menu where we can select a location
func _on_choose_location_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/choose_location.tscn")
