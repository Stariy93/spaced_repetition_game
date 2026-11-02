extends Item_data
class_name Amulet_data

@export var regen: int = 10
@export var uses: int = 1
@export var recover_chance: float = 0.02

func _init() -> void:
	type = Type.AMULET
	
	
func generate_name() -> void:
	var prefix: String = "Large" if uses > 1 else "Small"
	var base_name: String = "Amulet"
	var suffix: String = "of Treatment" if recover_chance > 0.0 else ""
	
	item_name = ("%s %s %s" % [prefix, base_name, suffix]).strip_edges()
	
	
func save_item() -> Dictionary:
	var data: Dictionary = super.save_item()
	data["regen"] = regen
	data["uses"] = uses
	data["recover_chance"] = recover_chance
	return data
	
	
func load_item(data: Dictionary) -> void:
	super.load_item(data)
	regen = data.get("regen", 10)
	uses = data.get("uses", 1)
	recover_chance = data.get("recover_chance", 0.0)
	
	
func color_definition() -> Array:
	var R = 255
	var G = 255
	var B = 255
	R = R - regen * 5 if R - regen * 5 > 0 else 0
	G = round(G / uses)
	B = B - round(B * recover_chance)
	return [R, G, B, 255]



func item_description() -> String:
	var description = super.item_description()
	description = "\nregen > {0}".format([regen])
	description += "\nuses > {0}".format([uses])
	if recover_chance > 0:
		description += "\nrecover > {0} %".format([recover_chance*100])
	return description
