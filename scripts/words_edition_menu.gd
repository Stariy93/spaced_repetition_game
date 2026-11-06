extends Control
const WordPairEditing := preload("res://scenes/word_pair_editing.tscn")
@onready var scroll_box : VBoxContainer = $VBoxContainer/ScrollContainer/VBoxContainer
@onready var editing_panel: Panel = $Panel
@onready var edit_panel_line_edit_1 = $Panel/MarginContainer/VBoxContainer/WordHBoxContainer/WordLineEdit
@onready var edit_panel_line_edit_2 = $Panel/MarginContainer/VBoxContainer/TranslationHBoxContainer/TranslationLineEdit
var current_index: int


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
		var word: Dictionary = WordDictionary.word_dictionary[key]
		var item = WordPairEditing.instantiate()
		var studied: String = word.get("studied")
		var native: String = word.get("native")
		var index: int = int(key)
		scroll_box.add_child(item)
		item.add_words(studied, native, index)
		item.edit_button_signal.connect(_edit_button.bind())
		item.remove_button_signal.connect(_remove_button.bind())
		

func _edit_button(studied: String, native: String, index: int) -> void:
	editing_panel.visible = true
	current_index = index
	edit_panel_line_edit_1.text = studied
	edit_panel_line_edit_2.text = native

	
func _remove_button(index: int) -> void:
	WordDictionary.remove_dict_element(WordDictionary.word_dictionary, WordDictionary.WORDS_SAVE_PATH, index)
	for chid in scroll_box.get_children():
		chid.queue_free()
	add_word_pair()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_accept_button_pressed() -> void:
	WordDictionary.change_dict_key(WordDictionary.word_dictionary, WordDictionary.WORDS_SAVE_PATH, \
	current_index, edit_panel_line_edit_1.text, edit_panel_line_edit_2.text)
	editing_panel.visible = false
	for chid in scroll_box.get_children():
		chid.queue_free()
	add_word_pair()


func _on_censel_button_pressed() -> void:
	editing_panel.visible = false
