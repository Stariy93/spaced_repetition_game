extends Control
@export var inventory_data: Inventory_data

var slot_prefab = preload("res://scenes/inventory/item_slot.tscn")

@onready var grid_cotainer: GridContainer = $MarginContainer/VBoxContainer/InventoryPanel/MarginContainer/GridContainer
@onready var weapon_slot = $MarginContainer/VBoxContainer/EquippedPanel/WeaponItemSlot
@onready var armor_slot = $MarginContainer/VBoxContainer/EquippedPanel/ArmorItemSlot
@onready var drop_slot = $MarginContainer/VBoxContainer/EquippedPanel/DropItemSlot

var dragged_item: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_inventory()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func update_inventory() -> void:
	if WordDictionary.inventory_dict == {}:
		inventory_data.create_inventory_slots()
	else:
		WordDictionary.load_dict(WordDictionary.INVENTORY, WordDictionary.inventory_dict)
		inventory_data.inventory_load(WordDictionary.inventory_dict)
	for i: Item_slot_data in inventory_data.slot_list:
		if i.type == i.Type.ALL:
			var slot = slot_prefab.instantiate()
			slot.slot_data = i
			grid_cotainer.add_child(slot)
		elif i.type == i.Type.ARMOR:
			armor_slot.slot_data = i
			armor_slot.update_ui()
		elif i.type == i.Type.WEAPON:
			weapon_slot.slot_data = i
			weapon_slot.update_ui()

func _on_button_pressed() -> void:
	WordDictionary.inventory_dict = inventory_data.inventory_save()
	WordDictionary.save_dict(WordDictionary.inventory_dict, WordDictionary.INVENTORY)
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")



	
