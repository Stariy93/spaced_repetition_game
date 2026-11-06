extends Control
var studied: String = ""
var native: String = ""
@onready var word_label1: Label = $MarginContainer/VBoxContainer/HBoxContainer/Word1Label
@onready var word_lable2: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Word2Label
var index: int

signal edit_button_signal(studied: String, native: String, index: int)
signal remove_button_signal(word: String)

	
	
func add_words(new_studied, new_native, new_index) -> void:
	word_label1.text = new_studied
	studied = new_studied
	word_lable2.text = new_native
	native = new_native
	index = new_index

func _on_edit_button_pressed() -> void:
	edit_button_signal.emit(studied, native, index)


func _on_remove_button_pressed() -> void:
	remove_button_signal.emit(index)
