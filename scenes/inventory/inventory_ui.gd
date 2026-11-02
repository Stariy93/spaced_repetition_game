extends Control

var SlotPanel := preload("res://scenes/inventory/item_ui.tscn")

@onready var bottom_item_panel: VBoxContainer = \
$MarginContainer/VBoxContainer/ItemPanel/ScrollContainer/VBoxContainer

@export var data: Inventory_data


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_inventory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func load_inventory() -> void:
	data.inventory_load(WordDictionary.inventory_dict)
	for slotData in data.slot_list:
		if slotData["type"] == 3:
			var slot_data: Item_slot_data = Item_slot_data.new() 
			var slot = SlotPanel.instantiate()
			bottom_item_panel.add_child(slot)
			slot.set_item()
	
