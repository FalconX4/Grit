extends Node2D
class_name WorldItemBody

@export var item_data: ItemData

var world_item: WorldItem

func _ready() -> void:
	if not world_item:
		var world_item_data = create_world_item_data()
		world_item = world_item_data.create_world_item()
		world_item.setup(self, world_item_data)

func create_world_item_data() -> WorldItemData:
	return null
