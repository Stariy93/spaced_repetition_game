extends Control
const WordPairEditing := preload("res://scenes/word_pair_editing.tscn")
@onready var scroll_box : VBoxContainer = $VBoxContainer/ScrollContainer/VBoxContainer
@onready var editing_panel: Panel = $Panel
@onready var edit_panel_line_edit_1 = $Panel/MarginContainer/VBoxContainer/WordHBoxContainer/WordLineEdit
@onready var edit_panel_line_edit_2 = $Panel/MarginContainer/VBoxContainer/TranslationHBoxContainer/TranslationLineEdit
var old_key: String


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	editing_panel.visible = false
	add_word_pair()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


#Adding a new words to word pairs dictionary
func add_word_pair() -> void:
	if WordDictionary.word_dictionary.is_empty():
		return
	for key in WordDictionary.word_dictionary:
		var item = WordPairEditing.instantiate()
		var value = WordDictionary.word_dictionary[key]["translation"]
		scroll_box.add_child(item)
		item.add_words(key, value)
		item.edit_button_signal.connect(_edit_button)
		item.remove_button_signal.connect(_remove_button)
		

func _edit_button(word: String, translation: String) -> void:
	editing_panel.visible = true
	edit_panel_line_edit_1.text = word
	old_key = word
	edit_panel_line_edit_2.text = translation

	
func _remove_button(word: String) -> void:
	WordDictionary.remove_word(word)
	for chid in scroll_box.get_children():
		chid.queue_free()
	add_word_pair()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_accept_button_pressed() -> void:
	var new_value = {"translation": edit_panel_line_edit_2.text, "level": 1}
	WordDictionary.change_word_key(old_key, edit_panel_line_edit_1.text, new_value)
	editing_panel.visible = false
	for chid in scroll_box.get_children():
		chid.queue_free()
	add_word_pair()


func _on_censel_button_pressed() -> void:
	editing_panel.visible = false
