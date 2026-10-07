extends Control
var word: String = ""
var tr_word: String = ""
@onready var word_label1: Label = $MarginContainer/VBoxContainer/HBoxContainer/Word1Label
@onready var word_lable2: Label = $MarginContainer/VBoxContainer/HBoxContainer2/Word2Label


signal edit_button_signal(word: String, translations: String)
signal remove_button_signal(word: String)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_words(word_1, word_2) -> void:
	word_label1.text = word_1
	word = word_1
	word_lable2.text = word_2
	tr_word = word_2
	

func _on_edit_button_pressed() -> void:
	edit_button_signal.emit(word, tr_word)


func _on_remove_button_pressed() -> void:
	remove_button_signal.emit(word)
