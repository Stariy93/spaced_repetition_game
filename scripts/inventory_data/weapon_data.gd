extends Item_data
class_name Weapon_data

@export var damage: int = 5
@export var extra_damage_chance: float = 0.05
@export var crit_chance: float = 0.05

func _init() -> void:
	type = Type.WEAPON
	

func generate_name() -> void:
	var prefix = "Mighty" if extra_damage_chance > 0.0 else "Ordinary"
	var base_name = "Blade"
	var suffix = "of Crit" if crit_chance > 0.0 else ""
	
	# Склеиваем имя и удаляем лишние пробелы, если суффикса нет
	item_name = ("%s %s %s" % [prefix, base_name, suffix]).strip_edges()

func save_item() -> Dictionary:
	# Получаем базовый словарь и добавляем свои данные
	var data: Dictionary = super.save_item() 
	data["damage"] = damage
	data["extra_damage_chance"] = extra_damage_chance
	data["crit_chance"] = crit_chance
	return data

func load_item(data: Dictionary) -> void:
	# Загружаем базовые данные
	super.load_item(data) 
	damage = data.get("damage", 5)
	extra_damage_chance = data.get("extra_damage_chance", 0.05)
	crit_chance = data.get("crit_chance", 0.05)
	
	
func color_definition() -> Array:
	var R = 255
	var G = 255
	var B = 255
	R = R - damage * 5 if R - damage * 5 > 0 else 0
	G = G - round(G * extra_damage_chance)
	B = B - round(B * crit_chance)
	return [R, G, B, 255]
	
	
func item_description() -> String:
	var description = super.item_description()
	description += "\ndamage > {0}".format([damage])
	if extra_damage_chance > 0:
		description += "\nextra damage > {0} %".format([extra_damage_chance*100])
	if crit_chance > 0:
		description += "\ncrit > {0} %".format([crit_chance*100])
	return description
	
