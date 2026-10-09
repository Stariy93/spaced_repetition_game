extends VBoxContainer
@export var location_name: String
@export var required_words_amount: int
@export var enemies_level: int = 1
@export var normal_image: CompressedTexture2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Location1VBoxContainer/LocationNameLabel.text = location_name
	$Location1VBoxContainer/AddedWordsLabel.text = words_amount()
	if required_words_amount <= len(WordDictionary.word_dictionary):
		$Location1VBoxContainer/Location1TextureButton.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func words_amount() -> String:
	if len(WordDictionary.word_dictionary) < required_words_amount:
		var text: String = "added words -> {current}/{required}".format({
	"current": len(WordDictionary.word_dictionary),
	"required": required_words_amount})
		return text
	else:
		var text: String = "added words -> {required}/{required}".format({
			"required": required_words_amount
		})
		return text
		
		


func _on_location_1_texture_button_pressed() -> void:
	pass # Replace with function body.
