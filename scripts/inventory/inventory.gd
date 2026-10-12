extends Control
const ItemSlot = preload("res://scenes/inventory/item_slot.tscn")
@onready var obj: ColorRect = $ColorRect
@onready var grid_container: GridContainer = $MarginContainer/VBoxContainer/InventoryPanel/MarginContainer/GridContainer
var is_pressed: bool = false
const Item = preload("res://scenes/inventory/item.tscn")
@onready var armor_slot: Item_slot = $MarginContainer/VBoxContainer/EquippedPanel/ItemSlot
@onready var weapon_slot: Item_slot = $MarginContainer/VBoxContainer/EquippedPanel/ItemSlot2
@onready var drop_slot: Item_slot = $MarginContainer/VBoxContainer/EquippedPanel/ItemSlot4
@export var slot_list: Array[Item_slot]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_ui_inventory()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_pressed == true:
		obj.position = Vector2(mous_pos().x - obj.size.x/2, mous_pos().y - obj.size.y/2)
	print(is_pressed)



func mous_pos() -> Vector2:
	var mouse_pos = get_viewport().get_mouse_position()
	return mouse_pos


func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT:
		is_pressed = event.pressed
		
		
func load_ui_inventory() -> void:
	for slot in WordDictionary.inventory["items"]:
		var item_slot = ItemSlot.instantiate()
		slot_list.append(item_slot)
	for slot in slot_list:
		grid_container.add_child(slot)
		slot.place_item()
		
