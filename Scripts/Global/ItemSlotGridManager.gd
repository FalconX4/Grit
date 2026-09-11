extends Node

var gridList: Array[ItemSlotGrid]

func subscribe(grid: ItemSlotGrid) -> void:
	gridList.append(grid)
	grid.item_slot_drag_ended_failed.connect(on_item_slot_drag_failed)

func unsubscribe(grid: ItemSlotGrid) -> void:
	grid.item_slot_drag_ended_failed.disconnect(on_item_slot_drag_failed)
	gridList.erase(grid)

func on_item_slot_drag_failed(sender: ItemSlotGrid, last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool):
	for grid in gridList:
		if grid != sender and grid.is_processing_input():
			if grid.on_item_slot_dragged(last_mouse_position, slot_dragged, is_mouse_right_drag) != null:
				break 
