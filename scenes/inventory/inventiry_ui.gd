extends Control
class_name Inventory_UI

@export var data: Inventory_data

const slot_ui := preload("res://scenes/inventory/SlotUI.tscn")

@onready var armor_slot: SlotUI = $MarginContainer/VBoxContainer/PanelTop/ArmorSlot
@onready var weapon_slot: SlotUI = $MarginContainer/VBoxContainer/PanelTop/WeaponSlot
@onready var amulet_slot: SlotUI = $MarginContainer/VBoxContainer/PanelTop/AmuletSlot
@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/PanelBottom/GridContainer



var slots: Array[SlotUI]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	build_inventory()
	test()
	update_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func build_inventory() -> void:
	slots.clear()
	for child in grid_container.get_children():
		child.queue_free()
	if WordDictionary.inventory_dict.is_empty() or not WordDictionary.inventory_dict.has("slots"):
		data.create_inventory_slots()
	else:
		data.inventory_load(WordDictionary.inventory_dict)
	for slot_data:Item_slot_data in data.slot_list:
		if slot_data.type == slot_data.Type.ALL:
			var ui_slot: SlotUI = slot_ui.instantiate()
			ui_slot.slot_data = slot_data
			ui_slot.item_transferred.connect(replace_item)
			grid_container.add_child(ui_slot)
			slots.append(ui_slot)
			ui_slot.update()
		if slot_data.type == slot_data.Type.WEAPON:
			weapon_slot.slot_data = slot_data
			weapon_slot.item_transferred.connect(replace_item)
			slots.append(weapon_slot)
			weapon_slot.update()
		if slot_data.type == slot_data.Type.ARMOR:
			armor_slot.slot_data = slot_data
			armor_slot.item_transferred.connect(replace_item)
			slots.append(armor_slot)
			armor_slot.update()
		if slot_data.type == slot_data.Type.AMULET:
			amulet_slot.slot_data = slot_data
			amulet_slot.item_transferred.connect(replace_item)
			slots.append(amulet_slot)
			amulet_slot.update()
	


func _on_button_back_pressed() -> void:
	WordDictionary.save_dict(data.inventory_save(),\
	WordDictionary.INVENTORY)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func replace_item(from_index: int, to_index: int) -> void:
	var from_slot: Item_slot_data = null
	var to_slot: Item_slot_data = null

	for slot: Item_slot_data in data.slot_list:
		if slot.index == from_index:
			from_slot = slot
		elif slot.index == to_index:
			to_slot = slot
		if from_slot and to_slot:
			break

	if from_slot and to_slot:
		var temp_item = from_slot.item_data
		from_slot.item_data = to_slot.item_data
		to_slot.item_data = temp_item
		

	update_inventory()
			
			
func update_inventory() -> void:
	for slot in slots:
		slot.update()
		
			
	
func test() -> void:
	var generator: Item_generator = Item_generator.new()
	var item: Item_data = generator.generate_item(20)
	slots[0].slot_data.item_data = item
	
