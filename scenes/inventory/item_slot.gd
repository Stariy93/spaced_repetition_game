extends Control
class_name Item_slot
@onready var slot_icon: PanelContainer = $PanelContainer
const Item_preload = preload("res://scenes/inventory/item.tscn")
var item: Item
@onready var panel: PanelContainer = $PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_item(new_item: Item) -> void:
	item = new_item
	slot_icon.add_child(item)
	
	
func remove_item(new_item: Item) -> void:
	slot_icon.remove_child(new_item)
	
	
func place_item() -> void:
	var item_preload = Item_preload.instantiate()
	item_preload.set_item("res://arts/weapon_1.png", self)
	add_item(item_preload)	
