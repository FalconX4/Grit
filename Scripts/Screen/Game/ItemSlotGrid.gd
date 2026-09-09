extends GridContainer
class_name ItemSlotGrid

@export var item_slot: PackedScene
@export var rows: int = 5

signal item_slot_clicked(slot_index)
signal item_slot_drag_ended(slot_dragged_index, slot_final_index)

var slots : Array[ItemSlot]
var _last_selected_index: int = -1

func _ready() -> void:
	var is_main_scene = Helpers.is_main_scene(self)
	for i in rows:
		for j in columns:
			var slot = item_slot.instantiate()
			slot.setup(i * columns + j)
			slot.click.connect(on_item_slot_clicked)
			slot.drag_ended.connect(on_item_slot_drag_ended)
			slots.append(slot)
			add_child(slot, true)

			if is_main_scene:
				slot.set_random_item()


func on_item_slot_clicked(_slot_index: int) -> void:
	_last_selected_index = _slot_index
	item_slot_clicked.emit(_slot_index)


func on_item_slot_drag_ended(last_mouse_position: Vector2, slot_dragged_index: int, is_mouse_right_drag: bool) -> void:
	for i in len(slots):
		if i != slot_dragged_index and slots[i].get_global_rect().has_point(last_mouse_position):
			_last_selected_index = i
			var has_moved = !is_mouse_right_drag
			if is_mouse_right_drag:
				has_moved = move_half_item(slots[slot_dragged_index], slots[i])
			else:
				move_all_item(slots[slot_dragged_index], slots[i])

			if has_moved:
				item_slot_drag_ended.emit(slot_dragged_index, i)
			break


func move_half_item(from: ItemSlot, to: ItemSlot) -> bool:
	if to.current_item_data_count == null:
		var new_item_data_count = ItemDataCount.new()
		new_item_data_count.item = from.current_item_data_count.item
		to.set_item(new_item_data_count)
	if to.current_item_data_count.item.name == from.current_item_data_count.item.name:
		var count = floori(from.current_item_data_count.count * 0.5)
		to.current_item_data_count.count += count
		from.current_item_data_count.count -= count
		from.item_slot_selected.remove()
		to.item_slot_selected.add()
		return true
	return false


func move_all_item(from: ItemSlot, to: ItemSlot) -> void:
	if to.current_item_data_count == null or to.current_item_data_count.item.name != from.current_item_data_count.item.name:
		var temp_item_data = to.current_item_data_count
		to.set_item(from.current_item_data_count)
		from.set_item(temp_item_data)
	else:
		to.current_item_data_count.count += from.current_item_data_count.count
		from.delete_item()
	from.item_slot_selected.remove()
	to.item_slot_selected.add()


func set_random_items() -> void:
	for slot in slots:
		slot.set_random_item()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		if event.keycode == KEY_S:
			sort()
		elif event.keycode == KEY_P:
			stack()


func sort() -> void:
	for i in len(slots) - 1:
		var is_null = slots[i].current_item_data_count == null
		for j in range(i + 1, len(slots)):
			if slots[j].current_item_data_count != null and (is_null or slots[i].current_item_data_count.item.name > slots[j].current_item_data_count.item.name):
				var temp = slots[i].current_item_data_count
				slots[i].current_item_data_count = slots[j].current_item_data_count
				slots[j].current_item_data_count = temp
				is_null = false


func stack() -> void:
	for i in len(slots) - 1:
		if slots[i].current_item_data_count != null:
			for j in range(i + 1, len(slots)):
				if slots[j].current_item_data_count != null and slots[i].current_item_data_count.item.name == slots[j].current_item_data_count.item.name:
					slots[i].current_item_data_count.count += slots[j].current_item_data_count.count
					slots[j].delete_item()
