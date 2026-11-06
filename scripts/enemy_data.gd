extends Resource

class_name Enemy

enum Type {STUDIED_NATIVE, NATIVE_STIDIED, MIXED, MANUAL_INPUT}


@export var enemy_name: String
@export var icon_path: String
@export var level: int
@export var health_max: int
@export var damage: int
@export var block: int
@export var type: Type


func take_damage(damage: int) -> void:
	if health_max > 0:
		health_max -= max(1, damage - block)
		
		
func  hit() -> int:
	return randi_range(round(damage*0.5), round(damage*1.5))
	
	



	

			
