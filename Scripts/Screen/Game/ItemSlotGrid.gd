extends GridContainer
class_name ItemSlotGrid

@export var item_slot: PackedScene
@export var rows: int = 5

signal item_slot_clicked(slot_index)
signal item_slot_drag_ended_failed(sender: ItemSlotGrid, last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool)
signal item_slot_drag_ended_sucess(from: ItemSlot, to: ItemSlot)

var slots : Array[ItemSlot]

func _ready() -> void:
	ItemSlotGridManager.subscribe(self)
	var is_main_scene = Helpers.is_main_scene(self)
	for i in rows:
		for j in columns:
			var slot = item_slot.instantiate() as ItemSlot
			slot.setup(i * columns + j)
			slot.click.connect(on_item_slot_clicked)
			slot.drag_ended.connect(on_item_slot_drag_ended)
			slots.append(slot)
			add_child(slot, true)
			if is_main_scene:
				slot.set_random_item()


func _process(delta: float) -> void:
	set_process_input(is_visible_in_tree())


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		if event.keycode == KEY_S:
			sort()
		elif event.keycode == KEY_P:
			stack()


func _exit_tree() -> void:
	ItemSlotGridManager.unsubscribe(self)
	for slot in slots:
		slot.queue_free()


func on_item_slot_clicked(_item_slot: ItemSlot) -> void:
	item_slot_clicked.emit(_item_slot)


func on_item_slot_drag_ended(last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool) -> void:
	var slot_dragged_into = on_item_slot_dragged(last_mouse_position, slot_dragged, is_mouse_right_drag)
	if slot_dragged_into == null:
		item_slot_drag_ended_failed.emit(self, last_mouse_position, slot_dragged, is_mouse_right_drag)
	else:
		item_slot_drag_ended_sucess.emit(slot_dragged, slot_dragged_into)


func on_item_slot_dragged(last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool) -> ItemSlot:
	for i in len(slots):
		if slots[i] != slot_dragged and slots[i].get_global_rect().has_point(last_mouse_position):
			var has_moved = !is_mouse_right_drag
			if is_mouse_right_drag:
				has_moved = slot_dragged.move_half_item_to(slots[i])
			else:
				slot_dragged.move_all_item_to(slots[i])

			if has_moved:
				return slots[i]
			break
	return null


func set_random_items() -> void:
	for slot in slots:
		slot.set_random_item()


func sort() -> void:
	var slot_count = len(slots)
	for i in slot_count - 1:
		var is_empty = not slots[i].has_item()
		for j in range(i + 1, slot_count):
			if slots[j].has_item() and (is_empty or not slots[i]._item_data_count.compare(slots[j]._item_data_count) > 0):
				slots[i].swap_item(slots[j])
				is_empty = false


func stack() -> void:
	var slot_count = len(slots)
	for i in slot_count - 1:
		if slots[i].has_item():
			for j in range(i + 1, slot_count):
				if slots[j].has_item() and slots[i].is_same_item(slots[j]):
					slots[j].transfer_count_to(slots[i])
