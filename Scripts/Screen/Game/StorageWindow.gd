extends Control
class_name StorageWindow

@export var grid: ItemSlotGrid

func _ready() -> void:
	if Helpers.is_main_scene(self):
		call_deferred("set_random_items")


func set_random_items() -> void:
	grid.set_random_items()
