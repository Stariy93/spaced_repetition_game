extends Control
@export var enemy: Enemy
@onready var enemy_name: Label = $MarginContainer/VBoxContainer/EnemyNameLabel
@onready var enemy_health_bar: ProgressBar = $MarginContainer/VBoxContainer/HBoxContainer/EnemyHPProgressBar
@onready var enemy_icon: TextureRect = $MarginContainer/VBoxContainer/EnemyIconTextureRect
@onready var word: Label = $MarginContainer/VBoxContainer/WordPanel/WordLabel
@onready var words_list: Dictionary = WordDictionary.word_dictionary.duplicate()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_enemy_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_enemy_ui() -> void:
	print(WordDictionary.word_dictionary)
	var key_value = get_word()
	enemy_name.text = enemy.enemy_name
	enemy_health_bar.min_value = 0
	enemy_health_bar.max_value = enemy.health_max
	enemy_health_bar.value = 35
	enemy_icon.texture = load(enemy.icon_path)
	word.text = key_value[0]
	

	
	
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
	
