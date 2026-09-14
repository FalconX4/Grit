extends GridContainer
class_name ItemSlotGrid

@export var item_slot: PackedScene
@export var rows: int = 5

signal item_slot_clicked(slot_index)
signal item_slot_drag_ended_failed(sender: ItemSlotGrid, last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool)
signal item_slot_drag_ended_success(from: ItemSlot, to: ItemSlot)

var slots : Array[ItemSlot]
var character_input_handler_selected_index: Dictionary[CharacterInputHandler, int]

func _ready() -> void:
	Pool.create(item_slot, rows * columns)
	ItemSlotGridManager.subscribe(self)
	_on_open()
	if GameSessionData.player_count_on_this_computer == 1:
		var input_handler = CharacterInputManager.player_input_handlers[0]
		character_input_handler_selected_index[input_handler] = -1
		if input_handler.input.using_controller:
			slots[0].item_slot_selected.add_character_input(input_handler)
	if Helpers.is_main_scene(self):
		for slot in slots:
			slot.set_random_item()


func _on_open() -> void:
	for i in rows:
		for j in columns:
			var slot = Pool.take(item_slot, self) as ItemSlot
			slot.setup(i * columns + j)
			slot.click.connect(on_item_slot_clicked)
			slot.drag_ended.connect(on_item_slot_drag_ended)
			slots.append(slot)


func _on_close() -> void:
	for slot in slots:
		slot.click.disconnect(on_item_slot_clicked)
		slot.drag_ended.disconnect(on_item_slot_drag_ended)
		Pool.release(slot)
	slots.clear()


func _exit_tree() -> void:
	ItemSlotGridManager.unsubscribe(self)
	_on_close()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	for character in character_input_handler_selected_index.keys():
		if character.is_my_event(event):
			var old_index = character_input_handler_selected_index[character]
			var check_index = old_index
			if old_index > -1 and slots[old_index]._item_slot_dragged_to != null:
				check_index = slots[old_index]._item_slot_dragged_to._index
			var new_index = get_new_index_from_input(check_index, event, character.input)
			if slots[old_index]._item_slot_dragged_to != null:
				slots[old_index].move_input_drag(slots[new_index])
			elif new_index != old_index:
				if old_index == -1:
					character_input_handler_selected_index[character] = 0
					slots[0].item_slot_selected.add_character_input(character)
				else:
					slots[old_index].item_slot_selected.remove_character_input(character)
					slots[new_index].item_slot_selected.add_character_input(character)
					character_input_handler_selected_index[character] = new_index


func get_new_index_from_input(last_index: int, event: InputEvent, character_input: CharacterInput = null) -> int:
	if character_input.is_action_just_pressed(InputMapNames.GAME_MOVE_LEFT, event):
		return last_index + columns - 1 if last_index == 0 or (last_index - 1) % columns == columns - 1 else last_index - 1
	if character_input.is_action_just_pressed(InputMapNames.GAME_MOVE_RIGHT, event):
		return last_index - columns + 1 if (last_index + 1) % columns == 0 else last_index + 1
	if character_input.is_action_just_pressed(InputMapNames.GAME_MOVE_UP, event):
		@warning_ignore("integer_division")
		return last_index + (rows - 1) * columns if (last_index / columns) == 0 else last_index - columns
	if character_input.is_action_just_pressed(InputMapNames.GAME_MOVE_DOWN, event):
		@warning_ignore("integer_division")
		return last_index - (rows - 1) * columns if last_index / columns >= rows - 1 else last_index + columns
	return last_index


func set_enable(enable: bool) -> void:
	Helpers.node_process(self, enable)
	if enable:
		if slots.is_empty():
			_on_open()
	else:
		_on_close()


func on_item_slot_clicked(_item_slot: ItemSlot) -> void:
	character_input_handler_selected_index[CharacterInputManager._last_input_handler] = _item_slot._index
	item_slot_clicked.emit(_item_slot)


func on_item_slot_drag_ended(last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool) -> void:
	var slot_dragged_into = on_item_slot_dragged(last_mouse_position, slot_dragged)
	if slot_dragged_into == null:
		item_slot_drag_ended_failed.emit(self, last_mouse_position, slot_dragged, is_mouse_right_drag)
	else:
		character_input_handler_selected_index[CharacterInputManager._last_input_handler] = slot_dragged_into._index
		item_slot_drag_ended_success.emit(slot_dragged, slot_dragged_into)


func on_item_slot_dragged(last_mouse_position: Vector2, slot_dragged: ItemSlot) -> ItemSlot:
	for i in len(slots):
		if slots[i] != slot_dragged and slots[i].get_global_rect().has_point(last_mouse_position):
			if slot_dragged.move_item_to(slots[i]):
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
