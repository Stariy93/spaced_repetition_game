extends Resource
class_name Player
@export var level: int
@export var health_max: int
var health: int
var exp: int = 0
@export var damage: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func take_damade(enemy_damage: int) -> void:
	if health > 0:
		health += enemy_damage
