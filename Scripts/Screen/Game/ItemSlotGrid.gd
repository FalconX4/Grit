extends GridContainer
class_name ItemSlotGrid

@export var item_slot: PackedScene
@export var rows: int = 5

signal item_slot_clicked(slot_index)
signal item_slot_drag_ended_failed(sender: ItemSlotGrid, last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool)
signal item_slot_drag_ended_success(from: ItemSlot, to: ItemSlot)

var slots : Array[ItemSlot]
var player_selected_index: Dictionary[Player, int]

func _ready() -> void:
	Pool.create(item_slot, rows * columns)
	ItemSlotGridManager.subscribe(self)
	_on_open()
	if GameSessionData.player_count_on_this_computer == 1:
		var player = CharacterManager.players[0]
		player_selected_index[player] = -1
		if player.character.input_handler.input.using_controller:
			slots[0].item_slot_selected.add_player(player)
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
			slot.stack.connect(stack_slot)
			slots.append(slot)


func _on_close() -> void:
	for slot in slots:
		slot.click.disconnect(on_item_slot_clicked)
		slot.drag_ended.disconnect(on_item_slot_drag_ended)
		slot.stack.disconnect(stack_slot)
		Pool.release(slot)
	slots.clear()


func _exit_tree() -> void:
	ItemSlotGridManager.unsubscribe(self)
	_on_close()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	for player in player_selected_index.keys():
		if player.character.input_handler.is_my_event(event):
			var old_index = player_selected_index[player]
			if slots[old_index].split.visible:
				continue
			var check_index = old_index
			if old_index > -1 and slots[old_index]._item_slot_dragged_to != null:
				check_index = slots[old_index]._item_slot_dragged_to._index
			var new_index = get_new_index_from_input(check_index, event, player.character.input_handler.input)
			if slots[old_index]._item_slot_dragged_to != null:
				slots[old_index].move_input_drag(slots[new_index])
			elif new_index != old_index:
				if old_index == -1:
					player_selected_index[player] = 0
					slots[0].item_slot_selected.add_player(player)
				else:
					slots[old_index].item_slot_selected.remove_player(player)
					slots[new_index].item_slot_selected.add_player(player)
					player_selected_index[player] = new_index


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
	player_selected_index[CharacterManager._last_inputted_player] = _item_slot._index
	item_slot_clicked.emit(_item_slot)


func on_item_slot_drag_ended(last_mouse_position: Vector2, slot_dragged: ItemSlot, is_mouse_right_drag: bool) -> void:
	var slot_dragged_into = on_item_slot_dragged(last_mouse_position, slot_dragged)
	if slot_dragged_into == null:
		item_slot_drag_ended_failed.emit(self, last_mouse_position, slot_dragged, is_mouse_right_drag)
	else:
		player_selected_index[CharacterManager._last_inputted_player] = slot_dragged_into._index
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
				if slots[i].is_same_item(slots[j]):
					slots[j].transfer_count_to(slots[i])


func stack_slot(slot: ItemSlot) -> void:
	var slot_count = len(slots)
	for i in slot_count:
		if i != slot._index and slots[i].is_same_item(slot):
			slots[i].transfer_count_to(slot)


func transfer_stacks_to(grid: ItemSlotGrid) -> bool: return transfer_all_to(grid, true)
func transfer_all_to(grid: ItemSlotGrid, only_stack: bool = false) -> bool:	return transfer_all_items_to(grid.slots, only_stack)
func transfer_all_items_to(items: Array, only_stack: bool = false) -> bool:
	var other_items_had_empty = true
	for slot in slots:
		if not slot.has_item():
			continue
		# Stack first
		var has_stack = false
		for other_item in items:
			if other_item.is_same_item(slot._item_data_count):
				has_stack = true
				slot.transfer_item_count_to(other_item)
				if slot._item_data_count.count == 0:
					break
		# Add in empty if still has count
		if other_items_had_empty and (not only_stack or has_stack) and slot._item_data_count.count > 0:
			for other_item in items:
				if not other_item.has_item():
					other_item.set_values(slot._item_data_count.item, 0)
					slot.transfer_item_count_to(other_item)
					if slot._item_data_count.count == 0:
						break
		# Other item list is full
		if slot._item_data_count.count > 0:
			other_items_had_empty = false
	return other_items_had_empty
