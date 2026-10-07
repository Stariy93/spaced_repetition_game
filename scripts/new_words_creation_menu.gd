extends Control
@onready var value1: LineEdit = $VBoxContainer/Value1LineEdit
@onready var value2: LineEdit = $VBoxContainer/Value2LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#This function changes word and translations, save a new values and clear imput fields
func _on_accept_button_pressed() -> void:
	WordDictionary.word_dictionary[value1.text] = {}
	WordDictionary.word_dictionary[value1.text] = {"translation": value2.text, "level": 1}
	WordDictionary.save_dictionary()
	$VBoxContainer/Value1LineEdit.text = ""
	$VBoxContainer/Value2LineEdit.text = ""

#Move to main menu
func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
