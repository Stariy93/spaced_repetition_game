extends Resource
class_name Item_slot_data

enum Type {WEAPON, ARMOR, AMULET, ALL}

@export var index: int
@export var type: Type
@export var item_data: Item_data = null


func save_slot() -> Dictionary:
	return {
		"index": index,
		"type": Type.find_key(type),
		"item": item_data.save_item() if item_data else null
	}
	
	
func load_slot(data: Dictionary) -> void:
	index = data.get("index", 0)
	type = Type[data.get("type", "ALL")]
	var item_dict = data.get("item", null)
	if item_dict == null:
		item_data = null
	else:
		item_data = _instantiate_item(item_dict)
		if item_data:
			item_data.load_item(item_dict)
			
			
func _instantiate_item(dict: Dictionary) -> Item_data:
	var item_type_str: String = dict.get("type", "")
	match item_type_str:
		"WEAPON":
			return Weapon_data.new()
		"ARMOR":
			return Armor_data.new()
		"AMULET":
			return Amulet_data.new()
	return Item_data.new()
		
		
func add_item_data(new_item_data: Item_data) -> void:
	if self.type == Type.ALL:
		item_data = new_item_data
	if self.type == new_item_data.type:
		item_data = new_item_data
	
	
func remove_item() -> void:
	item_data = null
	
	
func can_accept_item(item_data: Item_data) -> bool:
	if self.type == self.Type.ALL:
		return true
	elif item_data.type == self.type:
		return true
	else:
		return false
	
	






	

	
	

	
