extends Control
class_name StorageWindow

@export var grid: ItemSlotGrid

func _ready() -> void:
	if Helpers.is_main_scene(self):
		call_deferred("set_random_items")


func set_random_items() -> void:
	grid.set_random_items()


func set_enable(enable: bool) -> void:
	Helpers.node_process(self, enable)
	grid.set_enable(enable)


func _take_all() -> void:
	if CharacterManager._last_inputted_player:
		if not grid.transfer_all_items_to(CharacterManager._last_inputted_player.character.data.inventory_bar, true):
			grid.transfer_all_items_to(CharacterManager._last_inputted_player.character.data.inventory)
