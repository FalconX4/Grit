extends Control
class_name ItemSlot

@export var background: NinePatchRect
@export var draggable_button: DraggableButton
@export var right_click_menu_button: ItemSlotRightClickMenu
@export var item_texture_rect: TextureRect
@export var item_slot_selected: ItemSlotSelected
@export var count_label: Label

@export var control_dragged: Control
@export var item_dragged: TextureRect
@export var count_label_dragged: Label
@export var input_dragged_offset: Vector2 = Vector2(10, 10)

@export var remove_icon_timer: IconTimer
@export var split: HSlider

var _item_data_count = ItemDataCount.new(null, 0)
var _index = 0
var _item_slot_dragged_to: ItemSlot
var _item_count_dragged: int

signal click(item_slot: ItemSlot)
signal drag_ended(last_mouse_position: Vector2, item_slot: ItemSlot, is_mouse_right_drag: bool)
signal stack(item_slot: ItemSlot)

func setup(index : int) -> void:
	_index = index


func set_item(item_data_count: ItemDataCount) -> void:
	_item_data_count = item_data_count


func copy_item(item_data_count: ItemDataCount) -> void:
	_item_data_count.copy(item_data_count)


func swap_item(item_slot: ItemSlot) -> void:
	var item = item_slot._item_data_count.item
	var count = item_slot._item_data_count.count
	item_slot.copy_item(_item_data_count)
	set_item_data_count(item, count)


func set_item_data_count(item_data: ItemData, count: int) -> void:
	_item_data_count.set_values(item_data, count)


func transfer_count_to(item_slot: ItemSlot, count: int = 0) -> void:
	item_slot._item_data_count.transfer_count(_item_data_count, count)


func transfer_item_count_to(item: ItemDataCount, count: int = 0) -> void:
	item.transfer_count(_item_data_count, count)


func set_random_item() -> void:
	set_item_data_count(RandomManager.get_array(DataManager.items_data.items), RandomManager.get_i(100))


func has_item() -> bool:
	return _item_data_count.has_item()


func is_same_item(item_slot: ItemSlot) -> bool:
	return _item_data_count.is_same_item(item_slot._item_data_count)


func empty_item() -> void:
	_item_data_count.empty()


func move_item_to(to: ItemSlot) -> bool:
	var same_item = is_same_item(to)
	if not to.has_item():
		to.set_item_data_count(_item_data_count.item, 0)
		same_item = true
	var moved = same_item or _item_data_count.count == _item_count_dragged
	if same_item:
		transfer_count_to(to, _item_count_dragged)
	elif _item_data_count.count == _item_count_dragged:
		swap_item(to)
	if moved:
		item_slot_selected.remove_player(CharacterManager._last_inputted_player)
		to.item_slot_selected.add_player(CharacterManager._last_inputted_player)
	return moved


func start_input_drag(is_mouse_right_click: bool) -> void:
	draggable_button.prepare_dragging(false)
	draggable_button.start_dragging(global_position + input_dragged_offset, is_mouse_right_click)
	draggable_button.toggle_mode = true
	draggable_button.button_pressed = true
	_item_slot_dragged_to = self


func move_input_drag(item_slot: ItemSlot) -> void:
	_item_slot_dragged_to = item_slot
	draggable_button.global_position = item_slot.global_position + input_dragged_offset


func accept_input_drag() -> void:
	stop_input_drag(_item_slot_dragged_to.global_position)


func cancel_input_drag() -> void:
	stop_input_drag(global_position)


func stop_input_drag(_new_global_position: Vector2) -> void:
	draggable_button.stop_dragging(global_position, _new_global_position)
	reset_draggable_button()


func reset_draggable_button() -> void:
	draggable_button.toggle_mode = false
	draggable_button.button_pressed = false
	_item_slot_dragged_to = null


func want_stop_drag() -> bool:
	return not draggable_button.dragging or (InputManager._last_input_event as InputEventMouseButton).button_index == MouseButton.MOUSE_BUTTON_LEFT


func half_dragged_count() -> void:
	_item_count_dragged = int(_item_count_dragged * 0.5) if _item_count_dragged > 1 else 1
	count_label_dragged.text = str(_item_count_dragged)


func _ready() -> void:
	remove_icon_timer.timeout.connect(empty_item)
	draggable_button.can_drag = has_item
	draggable_button.can_stop_drag = want_stop_drag
	draggable_button.drag_started.connect(_drag_started)
	draggable_button.drag_moved.connect(_drag_moved)
	draggable_button.drag_ended.connect(_drag_ended)
	if Helpers.is_main_scene(self):
		setup(0)
		set_random_item()


func _process(_delta: float) -> void:
	item_texture_rect.texture = _item_data_count.item.inventory_image if _item_data_count.has_item() else null
	Helpers.node_process(remove_icon_timer, not draggable_button.dragging and _item_data_count.has_item() and item_slot_selected.is_shown())
	count_label.text = str(_item_data_count.count - _item_count_dragged) if _item_data_count.has_item() else ""
	if control_dragged.visible:
		count_label_dragged.text = str(_item_count_dragged) if control_dragged.visible else ""
	else:
		_item_count_dragged = 0


func _on_button_down() -> void:
	item_slot_selected.add_player(CharacterManager._last_inputted_player)
	click.emit(self)


func _input(event: InputEvent) -> void:
	if not item_slot_selected.is_shown():
		return
	for player in item_slot_selected.players:
		if not player.character.input_handler.is_my_event(event):
			continue
		var wants_drag = player.character.input_handler.input.is_action_just_pressed(InputMapNames.UI_ACCEPT, event)
		if wants_drag or player.character.input_handler.input.is_action_just_pressed(InputMapNames.GAME_ITEM_HALF, event):
			if draggable_button.dragging:
				if _item_slot_dragged_to != null:
					if not wants_drag:
						half_dragged_count()
					elif split.visible:
						split.visible = false
					else:
						accept_input_drag()
						accept_event()
			else:
				start_input_drag(not wants_drag)
		elif player.character.input_handler.input.is_action_just_pressed(InputMapNames.UI_CANCEL, event):
			if _item_slot_dragged_to != null:
				cancel_input_drag()
		elif player.character.input_handler.input.is_action_just_pressed(InputMapNames.GAME_INVENTORY):
			right_click_menu_button.show_popup()
	if event is InputEventMouseButton and event.is_pressed():
		if not draggable_button.get_global_rect().has_point(event.position):
			if not split.visible or not split.get_global_rect().has_point(event.position):
				if draggable_button.dragging:
					cancel_input_drag()
				item_slot_selected.remove_player(CharacterManager._last_inputted_player)
		elif draggable_button.dragging:
			if _item_slot_dragged_to != null:
				reset_draggable_button()
				draggable_button.wants_drag = true
				draggable_button.starting_mouse_position = (event as InputEventMouseButton).position - input_dragged_offset
			if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
				half_dragged_count()


func _drag_started(is_mouse_right_drag: bool) -> void:
	if _item_data_count.has_item():
		_item_count_dragged = _item_data_count.count
		if is_mouse_right_drag and _item_count_dragged > 1:
			_item_count_dragged = int(_item_data_count.count * 0.5)
		split.visible = false
		right_click_menu_button.disabled = true
		control_dragged.visible = true
		item_dragged.texture = _item_data_count.item.inventory_image
		count_label_dragged.text = str(_item_count_dragged)
		count_label.text = str(_item_data_count.count - _item_count_dragged)


func _drag_moved(_start_mouse_position: Vector2, _last_mouse_position: Vector2) -> void:
	split.visible = false


func _drag_ended(_start_mouse_position: Vector2, last_mouse_position: Vector2) -> void:
	right_click_menu_button.disabled = false
	control_dragged.visible = false
	split.visible = false
	if not get_global_rect().has_point(last_mouse_position):
		drag_ended.emit(last_mouse_position, self, draggable_button.is_mouse_right_drag)


func _take_half() -> void:
	if InputManager._last_input_event is InputEventMouse:
		draggable_button.prepare_dragging(true)
		draggable_button.start_dragging(global_position + get_global_mouse_position() - draggable_button.starting_mouse_position, true)
	else:
		start_input_drag(true)


func _split() -> void:
	start_input_drag(false)
	split.global_position = control_dragged.global_position + Vector2(0, control_dragged.size.y)
	split.visible = true
	split.grab_focus()
	split.min_value = 1
	split.max_value = _item_data_count.count
	split.value = 1
	split.value_changed.connect(_split_changed)
	_item_count_dragged = 1


func _split_changed(value: int) -> void:
	_item_count_dragged = value


func _stack() -> void:
	stack.emit(self)
