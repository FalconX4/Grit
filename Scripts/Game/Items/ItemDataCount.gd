class_name ItemDataCount

var item: ItemData
var count: int

func _init(_item: ItemData, _count: int) -> void:
	set_values(_item, _count)

func set_values(_item: ItemData, _count: int) -> void:
	item = _item
	count = _count

func copy(item_data_count: ItemDataCount) -> void:
	set_values(item_data_count.item, item_data_count.count)

func transfer_count(item_data_count: ItemDataCount, _count: int = 0) -> void:
	var transfer = _count if _count > 0 else item_data_count.count
	count += transfer
	item_data_count.count -= transfer

func has_item() -> bool:
	return count != 0

func empty() -> void:
	item = null
	count = 0

func is_same_item(item_data_count: ItemDataCount) -> bool:
	return item.name == item_data_count.item.name

func compare(other_item_data_count: ItemDataCount) -> int:
	var item_type = item.item_type()
	var other_item_type = other_item_data_count.item.item_type()
	if item_type == other_item_type:
		if item.name == other_item_data_count.item.name:
			return count - other_item_data_count.count
		return 1 if item.name > other_item_data_count.item.name else -1
	return item_type - other_item_type
