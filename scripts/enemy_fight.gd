extends Control
@export var enemy: Enemy
@export var player: Player
@onready var enemy_name: Label = $MarginContainer/VBoxContainer/EnemyNameLabel
@onready var enemy_health_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer/EnemyHPProgressBar
@onready var enemy_icon: TextureRect = $MarginContainer/VBoxContainer/EnemyIconTextureRect
@onready var player_health_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer2/PlayerHPProgressBar
@onready var word: Label = $MarginContainer/VBoxContainer/WordPanel/WordLabel
@onready var words_list: Dictionary = WordDictionary.word_dictionary.duplicate()
@onready var game_chat: RichTextLabel = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/GameChat
var front_side: String 
var back_side: String
var players_turn = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_word()
	set_enemy_ui()
	update_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_enemy_ui() -> void:
	print(WordDictionary.word_dictionary)
	if len(words_list) > 0:
		enemy.health = enemy.health_max
		player.health = player.health_max
		enemy_name.text = enemy.enemy_name
		enemy_health_bar.min_value = 0
		enemy_health_bar.max_value = enemy.health_max
		enemy_health_bar.value = enemy.health
		enemy_icon.texture = load(enemy.icon_path)
		player_health_bar.max_value = player.health_max
		player_health_bar.value = player.health
	else:
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	

	
	
func get_word() -> void:
	if words_list.is_empty():
		words_list = WordDictionary.word_dictionary.duplicate()
	var keys = words_list.keys()
	var random_key = keys[randi() % keys.size()]
	var random_value = words_list[random_key]
	words_list.erase(random_key)
	var key_value = [random_key, random_value]
	front_side = key_value[0]
	back_side = key_value[1]["translation"]
	word.text = key_value[0]
	


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
		get_word()
		update_ui()
		players_turn = false
		game_chat.text = "You dealt {damage} damage\nEnemy move".format({"damage" = player.damage})
	else :
		get_word()
		update_ui()
		players_turn = true
		game_chat.text = "You dodget\nYour move"
		

		
func _on_wrong_button_pressed() -> void:
	if players_turn == true:
		get_word()
		update_ui()
		players_turn = false
		game_chat.text = "You missed\nEnemy move"
	else:
		player.health -= enemy.damage
		player_health_bar.value = player.health
		get_word()
		update_ui()
		players_turn = true
		game_chat.text = "The enemy dealt {damage} damage\nPlayer move".format({"damage" = enemy.damage})
		
		
func update_ui() -> void:
	enemy_health_bar.value = enemy.health
	player_health_bar.value = player.health
	
