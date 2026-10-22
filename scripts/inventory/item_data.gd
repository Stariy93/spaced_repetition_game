extends Resource
class_name Item_data


enum Type {WEAPON, ARMOR, POTION}


@export var type: Type
@export var item_name: String
@export var level: int
@export var icon_path: String



	
func save_item() -> Dictionary:
	return {
		"type": Type.find_key(type),
		"name": item_name,
		"level": level,
		"icon_path": icon_path
	}
	
	
func load_item(data: Dictionary) -> void:
	type = Type[data.get("type", "WEAPON")]
	item_name = data.get("name", "")
	level = data.get("level", 1)
	icon_path = data.get("icon_path", "")
	
