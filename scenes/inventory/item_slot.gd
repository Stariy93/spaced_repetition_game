extends Control

var item_prefab = preload("res://scenes/inventory/item.tscn")

@export var slot_data: Item_slot_data

@onready var panel: PanelContainer = $PanelContainer

var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func update_ui() -> void:
	for child in panel.get_children():
		child.queue_free()

	if slot_data == null or slot_data.item_data == null:
		return

	var item = item_prefab.instantiate()
	item.item_data = slot_data.item_data
	panel.add_child(item)
	item.update_ui()
	
	

		

		
	
