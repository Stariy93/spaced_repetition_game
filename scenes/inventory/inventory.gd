extends Control

@export var inventory_data: Inventory_data
var slot_prefab = preload("res://scenes/inventory/item_slot.tscn")

@onready var grid_cotainer: GridContainer = $MarginContainer/VBoxContainer/InventoryPanel/MarginContainer/GridContainer
@onready var weapon_slot = $MarginContainer/VBoxContainer/EquippedPanel/WeaponItemSlot
@onready var armor_slot = $MarginContainer/VBoxContainer/EquippedPanel/ArmorItemSlot
@onready var drop_slot = $MarginContainer/VBoxContainer/EquippedPanel/DropItemSlot


func _ready() -> void:
	if inventory_data == null:
		inventory_data = Inventory_data.new()
	load_inventory()
	if inventory_data.slot_list.size() > 0 and inventory_data.slot_list[0].item_data == null:
		var test_item := Item_data.new()
		test_item.type = Item_data.Type.WEAPON
		test_item.item_name = "Test Sword"
		test_item.level = 1
		test_item.icon_path = "res://arts/weapon_1.png" # поставь путь к своей иконке

		inventory_data.slot_list[0].item_data = test_item
	build_inventory_ui()
	


func load_inventory() -> void:
	WordDictionary.inventory_dict = WordDictionary.load_dict(WordDictionary.INVENTORY)

	if WordDictionary.inventory_dict.is_empty():
		inventory_data.create_inventory_slots()
	else:
		inventory_data.inventory_load(WordDictionary.inventory_dict)


func build_inventory_ui() -> void:
	for child in grid_cotainer.get_children():
		child.queue_free()

	for s: Item_slot_data in inventory_data.slot_list:
		match s.type:
			Item_slot_data.Type.ALL:
				var slot = slot_prefab.instantiate()
				slot.slot_data = s
				slot.inventory_ui = self
				grid_cotainer.add_child(slot)

			Item_slot_data.Type.ARMOR:
				armor_slot.slot_data = s
				armor_slot.inventory_ui = self
				armor_slot.update_ui()

			Item_slot_data.Type.WEAPON:
				weapon_slot.slot_data = s
				weapon_slot.inventory_ui = self
				weapon_slot.update_ui()


func save_inventory_and_refresh() -> void:
	WordDictionary.inventory_dict = inventory_data.inventory_save()
	WordDictionary.save_dict(WordDictionary.inventory_dict, WordDictionary.INVENTORY)
	refresh_ui()


func refresh_ui() -> void:
	for child in grid_cotainer.get_children():
		child.update_ui()
	armor_slot.update_ui()
	weapon_slot.update_ui()


func _on_button_pressed() -> void:
	WordDictionary.inventory_dict = inventory_data.inventory_save()
	WordDictionary.save_dict(WordDictionary.inventory_dict, WordDictionary.INVENTORY)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



	
