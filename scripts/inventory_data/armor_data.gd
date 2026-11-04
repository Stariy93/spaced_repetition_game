extends Item_data
class_name Armor_data

@export var block: int = 2
@export var extra_block_chance: float = 0.05
@export var dodge_chance: float = 0.05


func _init() -> void:
	type = Type.ARMOR
	
	
func generate_name() -> void:
	var prefix: String = "Blocked" if extra_block_chance > 0.0 else "Leather"
	var base_name: String = "Bib"
	var suffix: String = "of Dodge" if dodge_chance > 0.0 else ""
	
	item_name = ("%s %s %s" % [prefix, base_name, suffix]).strip_edges()
	
	
func save_item() -> Dictionary:
	var data: Dictionary = super.save_item()
	data["block"] = block
	data["extra_block_chance"] = extra_block_chance
	data["dodge_chance"] = dodge_chance
	return data
	
	
func load_item(data: Dictionary) -> void:
	super.load_item(data)
	block = data.get("block", 2)
	extra_block_chance = data.get("extra_block_chance", 0.0)
	dodge_chance = data.get("dodge_chance", 0.0)
	
	
func color_definition() -> Array:
	var R = 255
	var G = 255
	var B = 255
	R = R - block * 10 if R - block * 5 > 0 else 0
	G = G - round(G * extra_block_chance)
	B = B - round(B * dodge_chance)
	return [R, G, B, 255]
	
	
func item_description() -> String:
	var description = super.item_description()
	description += "\nblock > {0}".format([block])
	if extra_block_chance > 0:
		description += "\nextra block > {0} %".format([extra_block_chance*100])
	if dodge_chance > 0:
		description += "\ndodge > {0} %".format([dodge_chance*100])
	return description
