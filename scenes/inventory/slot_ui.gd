extends Panel
class_name SlotUI

@export var slot_data: Item_slot_data

signal item_transferred

@onready var icon: TextureRect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func update() -> void:
	if slot_data and slot_data.item_data:
		icon.texture = load(slot_data.item_data.icon_path)
		icon.modulate = Color8(slot_data.item_data.image_color[0],\
		slot_data.item_data.image_color[1],slot_data.item_data.image_color[2],\
		slot_data.item_data.image_color[3])  
	else:
		icon.texture = null
		
		
func _get_drag_data(at_position: Vector2) -> Variant:
	if slot_data == null or slot_data.item_data == null:
		return null
	var preview := TextureRect.new()
	preview.texture = icon.texture
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.size = icon.size
	
	var previev_root := Control.new()
	preview.position = - 0.5 * size
	previev_root.add_child(preview)
	
	set_drag_preview(previev_root)
	
	return {"from_index": slot_data.index, "item_data": slot_data.item_data}
		


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	if not (data is Dictionary and data.has("from_index")):
		return false
	if data["from_index"] == slot_data.index:
		return false
	if slot_data.item_data != null:
		return false
	return slot_data.can_accept_item(data["item_data"])
	
	

func _drop_data(at_position: Vector2, data: Variant) -> void:
	item_transferred.emit(data["from_index"], slot_data.index)
	
