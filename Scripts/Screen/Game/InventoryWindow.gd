extends Control
class_name InventoryWindow

@export var grid: ItemSlotGrid

var selected_character: Character

func set_character(character: Character):
	selected_character = character

func _ready() -> void:
	if Helpers.is_main_scene(self):
		call_deferred("set_random_items")

func set_random_items() -> void:
	grid.set_random_items()

func set_enable(enable: bool) -> void:
	Helpers.node_process(self, enable)
	grid.set_enable(enable)
	if enable and selected_character != null:
		var lenItems = len(selected_character.data.inventory)
		for i in len(grid.slots):
			if i >= lenItems:
				grid.slots[i].empty_item()
			else:
				grid.slots[i].set_item(selected_character.data.inventory[i])
