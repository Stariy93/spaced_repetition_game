extends TextureRect
@export var item_data: Item_data 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func update_ui() -> void:
	if item_data == null:
		texture = null
	else:
		texture = load(item_data.icon_path)
	
	
