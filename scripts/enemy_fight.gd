extends Control
@export var enemy: Enemy
@export var player: Player
@onready var enemy_name: Label = $MarginContainer/VBoxContainer/EnemyNameLabel
@onready var enemy_health_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer/EnemyHPProgressBar
@onready var enemy_icon: TextureRect = $MarginContainer/VBoxContainer/EnemyIconTextureRect
@onready var player_health_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer2/PlayerHPProgressBar
@onready var word: Label = $MarginContainer/VBoxContainer/WordPanel/WordLabel
@onready var words_list: Dictionary = WordDictionary.word_dictionary.duplicate()
var front_side: String 
var back_side: String
var players_turn = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	enemy.health = enemy.health_max
	player.health = player.health_max
	set_enemy_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_enemy_ui() -> void:
	print(WordDictionary.word_dictionary)
	if len(words_list) > 0:
		var key_value = get_word()
		enemy_name.text = enemy.enemy_name
		enemy_health_bar.min_value = 0
		enemy_health_bar.max_value = enemy.health_max
		enemy_health_bar.value = enemy.health
		enemy_icon.texture = load(enemy.icon_path)
		player_health_bar.max_value = player.health_max
		player_health_bar.value = player.health
		front_side = key_value[0]
		back_side = key_value[1]["translation"]
		word.text = key_value[0]
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	

	
	
func get_word() -> Array:
	if words_list.is_empty():
		push_warning("Список слов пуст!")
		return ["", ""]
	var keys = words_list.keys()
	var random_key = keys[randi() % keys.size()]
	var random_value = words_list[random_key]
	words_list.erase(random_key)
	var key_value_list = [random_key, random_value]
	return key_value_list
	


func _on_turn_card_button_pressed() -> void:
	if word.text == front_side:
		word.text = back_side
		$MarginContainer/VBoxContainer/BoxContainer/RightButton.disabled = false
		$MarginContainer/VBoxContainer/BoxContainer/WrongButton.disabled = false
		return
	if word.text == back_side:
		word.text = front_side
		


func _on_right_button_pressed() -> void:
	if players_turn == true:
		enemy.health -= player.damage
		enemy_health_bar.value = enemy.health
		words_list.erase(front_side)
		set_enemy_ui()
		players_turn = false
	else :
		set_enemy_ui()
		players_turn = true
		

		
	


func _on_wrong_button_pressed() -> void:
	if players_turn == true:
		set_enemy_ui()
		players_turn = false
	else:
		player.health -= enemy.damage
		player_health_bar.value = player.health
		set_enemy_ui()
		players_turn = true
		
