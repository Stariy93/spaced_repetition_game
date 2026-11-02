extends Panel


@export var data: Item_data

@onready var description: RichTextLabel = $HBoxContainer/RichTextLabel
@onready var icon: TextureRect = $HBoxContainer/TextureRect
@onready var equip_btn: Button = $HBoxContainer/VBoxContainer/EquipButton
@onready var drop_button: Button = $HBoxContainer/VBoxContainer/DropButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_item()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func set_item() -> void:
	if data:
		icon.texture = load(data.icon_path)
		icon.modulate = Color8(data.image_color[0], data.image_color[1],\
		data.image_color[2], data.image_color[3])
		var description_text = data.item_description()
		description.text = description_text
	else:
		description.text = "empty"
		equip_btn.visible = false
		drop_button.visible = false
	
