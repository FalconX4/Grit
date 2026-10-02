class_name WorldItemData

var id: int
var position: Vector2
var rotation: float
var item_data: ItemWorldData

func _init(item: ItemWorldData, _position: Vector2, _rotation: float) -> void:
	item_data = item
	position = _position
	rotation = _rotation

func create_world_item() -> WorldItem:
	return WorldItem.new()
