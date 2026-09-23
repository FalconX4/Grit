class_name Character

var input_handler: CharacterInputHandler
var data: CharacterData
var body: CharacterBody

func _init() -> void:
	data = CharacterData.new()
	for i in range(20):
		data.inventory.append(ItemDataCount.new(null, 0))
	for i in range(10):
		data.inventory_bar.append(ItemDataCount.new(null, 0))
	data.inventory_bar[0].set_values(DataManager.items_data.items[len(DataManager.items_data.items) - 1], 1)
