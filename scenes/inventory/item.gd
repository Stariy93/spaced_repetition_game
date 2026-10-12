extends TextureRect
class_name Item
enum ItemTipe {WEAPON, ARMOR}
enum ItemValue {POOR, AVERAGE, RARE}
@export var item_type: ItemTipe
@export var level: int
var image_path: String
var slot: Item_slot




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_item(path, item_slot) -> void:
	image_path = path
	texture = load(image_path)
	slot = item_slot
