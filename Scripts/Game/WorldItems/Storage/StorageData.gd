extends WorldItemData
class_name StorageData

var items : Array[ItemDataCount]

func _init(item: ItemWorldData, _position: Vector2, _rotation: float) -> void:
	super._init(item, _position, _rotation)
	setup()

func setup() -> void:
	for i in item_data.rows:
		for j in item_data.columns:
			items.append(null)

func create_world_item() -> WorldItem:
	return Storage.new()
