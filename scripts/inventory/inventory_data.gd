extends Resource
class_name Inventory_data

@export var slots_amount: int = 9
var slot_list: Array[Item_slot_data] = []


func create_inventory_slots() -> void:
	slot_list.clear()

	# Обычные слоты
	for i in range(slots_amount):
		var slot := Item_slot_data.new()
		slot.index = i
		slot.type = Item_slot_data.Type.ALL
		slot_list.append(slot)

	# Экип-слоты
	var armor_slot := Item_slot_data.new()
	armor_slot.index = slots_amount
	armor_slot.type = Item_slot_data.Type.ARMOR
	slot_list.append(armor_slot)

	var weapon_slot := Item_slot_data.new()
	weapon_slot.index = slots_amount + 1
	weapon_slot.type = Item_slot_data.Type.WEAPON
	slot_list.append(weapon_slot)


func can_slot_accept_item(slot: Item_slot_data, item: Item_data) -> bool:
	if slot == null or item == null:
		return false

	if slot.type == Item_slot_data.Type.ALL:
		return true

	# Важно: первые 3 значения enum должны совпадать по порядку
	# Item_data.Type {WEAPON, ARMOR, POTION}
	# Item_slot_data.Type {WEAPON, ARMOR, POTION, ALL}
	return int(slot.type) == int(item.type)


func move_item(from_index: int, to_index: int) -> bool:
	if from_index == to_index:
		return false
	if from_index < 0 or from_index >= slot_list.size():
		return false
	if to_index < 0 or to_index >= slot_list.size():
		return false

	var from_slot: Item_slot_data = slot_list[from_index]
	var to_slot: Item_slot_data = slot_list[to_index]

	if from_slot.item_data == null:
		return false

	# Можно ли положить переносимый предмет в целевой слот?
	if not can_slot_accept_item(to_slot, from_slot.item_data):
		return false

	# Если целевой не пустой, проверяем swap-обратно
	if to_slot.item_data != null and not can_slot_accept_item(from_slot, to_slot.item_data):
		return false

	var temp: Item_data = to_slot.item_data
	to_slot.item_data = from_slot.item_data
	from_slot.item_data = temp
	return true


func inventory_save() -> Dictionary:
	var slots_arr: Array = []
	for slot in slot_list:
		slots_arr.append(slot.save_slot())

	return {
		"slots_amount": slots_amount,
		"slots": slots_arr
	}


func inventory_load(inventory_dict: Dictionary) -> void:
	slots_amount = int(inventory_dict.get("slots_amount", 9))
	slot_list.clear()

	for slot_data in inventory_dict.get("slots", []):
		var new_slot := Item_slot_data.new()
		new_slot.load_slot(slot_data)
		slot_list.append(new_slot)

	# Подстраховка, если файл пустой/битый
	if slot_list.is_empty():
		create_inventory_slots()
	
	




		
