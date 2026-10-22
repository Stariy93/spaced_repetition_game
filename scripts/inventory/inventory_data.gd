extends Resource
class_name Inventory_data

@export var slots_amount: int

var slot_list: Array



func create_inventory_slots() -> void:
	slot_list.clear()
	for i in range(slots_amount):
		var slot := Item_slot_data.new()
		slot.index = i
		slot.type = Item_slot_data.Type.ALL
		slot_list.append(slot)

	var armor_slot := Item_slot_data.new()
	armor_slot.index = slots_amount
	armor_slot.type = Item_slot_data.Type.ARMOR
	slot_list.append(armor_slot)

	var weapon_slot := Item_slot_data.new()
	weapon_slot.index = slots_amount + 1
	weapon_slot.type = Item_slot_data.Type.WEAPON
	slot_list.append(weapon_slot)
	
	
func inventory_save() -> Dictionary:
	var slots: Array = []
	for slot in slot_list:
		slots.append(slot.save_slot())
	return {"slots_amount": slots_amount, "slots": slots}
	
	
func inventory_load(inventory_dict: Dictionary) -> void:
	slots_amount = inventory_dict.get("slots_amount", 9)
	slot_list.clear()
	for slot_dict in inventory_dict.get("slots", []):
		var new_slot := Item_slot_data.new()
		new_slot.load_slot(slot_dict)
		slot_list.append(new_slot)
	
	




		
