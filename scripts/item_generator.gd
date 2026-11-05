extends Resource

class_name Item_generator

enum item_type {WEAPON, ARMOR, AMULET}

@export var weapon_image_list: Array = [
	["Sword", "res://arts/item_images/weapon_1.png"],
	["Axe", "res://arts/item_images/weapon_2.png"],
	["Mace", "res://arts/item_images/weapon_3.png"]
]

@export var armor_image_list: Array = [
	["Plate Armor", "res://arts/item_images/armor_1.png"],
	["Lamellar Armor", "res://arts/item_images/armor_2.png"],
	["Quilted Armor", "res://arts/item_images/armor_3.png"]
]

@export var amulet_image_list: Array = [
	["Diamond Amulet", "res://arts/item_images/amulet_1.png"],
	["Cristal Amulet", "res://arts/item_images/amulet_2.png"],
	["Star Amulet", "res://arts/item_images/amulet_3.png"]
]

		
func generate_item(lvl: int) -> Item_data:
	var random_type: Item_data.Type = Item_data.Type.values().pick_random()
	match random_type:
		Item_data.Type.WEAPON:
			return build_weapon(lvl)
		Item_data.Type.ARMOR:
			return build_armor(lvl)
		Item_data.Type.AMULET:
			return build_amulet(lvl)
	return null 
	
	
func build_armor(max_lvl: int) -> Armor_data:
	var item := Armor_data.new()
	var template: Array = armor_image_list.pick_random()
	item.base_name = template[0]
	item.icon_path = template[1]

	var lvl := randi_range(1, max_lvl)
	item.level = lvl
	item.block *= lvl

	# Chance to roll bonus attributes scales up with level (capped at 90%)
	var bonus_chance := minf(0.15 + (0.05 * lvl), 0.90)

	item.extra_block_chance = (item.extra_block_chance * (1.0 + lvl * 0.1)) if randf() <= bonus_chance else 0.0
	item.dodge_chance = (item.dodge_chance * (1.0 + lvl * 0.1)) if randf() <= bonus_chance else 0.0

	item.image_color = item.color_definition()
	item.generate_name()
	return item


func build_weapon(max_lvl: int) -> Weapon_data:
	var item := Weapon_data.new()
	var template: Array = weapon_image_list.pick_random()
	item.base_name = template[0]
	item.icon_path = template[1]

	var lvl := randi_range(1, max_lvl)
	item.level = lvl
	item.damage *= lvl

	var bonus_chance := minf(0.15 + (0.05 * lvl), 0.90)

	item.extra_damage_chance = (item.extra_damage_chance * (1.0 + lvl * 0.1)) if randf() <= bonus_chance else 0.0
	item.crit_chance = (item.crit_chance * (1.0 + lvl * 0.1)) if randf() <= bonus_chance else 0.0

	item.image_color = item.color_definition()
	item.generate_name()
	return item


func build_amulet(max_lvl: int) -> Amulet_data:
	var item := Amulet_data.new()
	var template: Array = amulet_image_list.pick_random()
	item.base_name = template[0]
	item.icon_path = template[1]

	var lvl := randi_range(1, max_lvl)
	item.level = lvl
	item.regen *= lvl

	if lvl < 5:
		item.uses = 1
	elif lvl <= 10:
		item.uses = randi_range(1, 2)
	else:
		item.uses = randi_range(1, 3)

	var bonus_chance := minf(0.15 + (0.05 * lvl), 0.90)
	item.recover_chance = (item.recover_chance * (1.0 + lvl * 0.1)) if randf() <= bonus_chance else 0.0

	item.image_color = item.color_definition()
	item.generate_name()
	return item
	
	
	
	
	
