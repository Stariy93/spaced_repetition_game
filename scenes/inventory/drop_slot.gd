extends TextureRect
class_name TrashSlotUI

# Сигнал, сообщающий менеджеру инвентаря, какой слот нужно очистить
signal item_destroyed(from_index: int)

func _ready() -> void:
	# Иконка или панель корзины должна реагировать на мышь
	mouse_filter = Control.MOUSE_FILTER_PASS
	tooltip_text = "Перетащите сюда предмет, чтобы уничтожить его"


func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	# Проверяем, что перетаскиваемый объект содержит индекс исходного слота
	return data is Dictionary and data.has("from_index")


func _drop_data(at_position: Vector2, data: Variant) -> void:
	var source_index: int = data["from_index"]
	
	# Оповещаем контроллер инвентаря об уничтожении предмета
	item_destroyed.emit(source_index)
