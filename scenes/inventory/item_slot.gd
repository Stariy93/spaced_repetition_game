extends Control

var item_prefab = preload("res://scenes/inventory/item.tscn")

@export var slot_data: Item_slot_data
var inventory_ui: Control

@onready var panel: PanelContainer = $PanelContainer


func _ready() -> void:
	update_ui()


func update_ui() -> void:
	for child in panel.get_children():
		child.queue_free()

	if slot_data == null or slot_data.item_data == null:
		return

	var item = item_prefab.instantiate()
	item.item_data = slot_data.item_data
	panel.add_child(item)
	item.update_ui()


func _get_drag_data(_at_position: Vector2):
	if slot_data == null or slot_data.item_data == null:
		return null

	var preview := TextureRect.new()
	var tex := load(slot_data.item_data.icon_path) as Texture2D
	preview.texture = tex
	preview.custom_minimum_size = Vector2(48, 48)
	set_drag_preview(preview)

	return {
		"from_index": slot_data.index
	}


func _can_drop_data(_at_position: Vector2, data) -> bool:
	print("CAN DROP on slot:", slot_data.index if slot_data else -1, " type:", slot_data.type if slot_data else -1)
	if inventory_ui == null:
		return false
	if typeof(data) != TYPE_DICTIONARY:
		return false
	if not data.has("from_index"):
		return false
	if slot_data == null:
		return false

	var from_i: int = int(data["from_index"])
	var inv: Inventory_data = inventory_ui.inventory_data

	if from_i < 0 or from_i >= inv.slot_list.size():
		return false

	var from_slot: Item_slot_data = inv.slot_list[from_i]
	if from_slot.item_data == null:
		return false

	# Целевой слот принимает этот тип?
	if not inv.can_slot_accept_item(slot_data, from_slot.item_data):
		return false

	# Если swap, исходный слот должен принять предмет из целевого
	if slot_data.item_data != null and not inv.can_slot_accept_item(from_slot, slot_data.item_data):
		return false

	return true


func _drop_data(_at_position: Vector2, data) -> void:
	if inventory_ui == null or slot_data == null:
		return

	var from_i: int = int(data["from_index"])
	var to_i: int = slot_data.index

	if inventory_ui.inventory_data.move_item(from_i, to_i):
		inventory_ui.save_inventory_and_refresh()
	
	

		

		
	
