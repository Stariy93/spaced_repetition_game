extends Resource
class_name Item_data


enum Type {WEAPON, ARMOR, AMULET}


@export var type: Type
@export var item_name: String
@export var level: int
@export var icon_path: String
@export var image_color: Array = [255, 255, 255, 255]



	
func save_item() -> Dictionary:
	return {
		"type": Type.find_key(type),
		"name": item_name,
		"level": level,
		"icon_path": icon_path,
		"image_color": [image_color[0], image_color[1], image_color[2], image_color[3]]
	}
	
	
func load_item(data: Dictionary) -> void:
	type = Type[data.get("type", "WEAPON")]
	item_name = data.get("name", "")
	level = data.get("level", 1)
	icon_path = data.get("icon_path", "")
	image_color = data.get("image_color", [255, 255, 255, 255])

	
	
func generate_name() -> void:
	pass
	
	
func item_description() -> String:
	var descriptions: String = "{0} {1} lvl".format([item_name, level])
	return descriptions 
	
	

	
	
