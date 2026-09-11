extends Control
class_name ItemSlot

@export var background: NinePatchRect
@export var draggable_button: DraggableButton
@export var item_texture_rect: TextureRect
@export var item_slot_selected: ItemSlotSelected
@export var count_label: Label

@export var control_dragged: Control
@export var item_dragged: TextureRect
@export var count_label_dragged: Label

@export var remove_icon_timer: IconTimer

var _item_data_count = ItemDataCount.new(null, 0)
var _index = 0
signal click(item_slot: ItemSlot)
signal drag_ended(last_mouse_position: Vector2, item_slot: ItemSlot, is_mouse_right_drag: bool)

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


func set_random_item() -> void:
	set_item_data_count(RandomManager.get_array(DataManager.items_data.items), RandomManager.get_i(100))


func has_item() -> bool:
	return _item_data_count.has_item()


func is_same_item(item_slot: ItemSlot) -> bool:
	return _item_data_count.is_same_item(item_slot._item_data_count)


func empty_item() -> void:
	_item_data_count.empty()


func move_half_item_to(to: ItemSlot) -> bool:
	if not to.has_item():
		to.set_item_data_count(_item_data_count.item, 0)
	if to._item_data_count.item.name == _item_data_count.item.name:
		transfer_count_to(to, floori(_item_data_count.count * 0.5))
		item_slot_selected.remove()
		to.item_slot_selected.add()
		return true
	return false


func move_all_item_to(to: ItemSlot) -> void:
	if to.has_item() and is_same_item(to):
		transfer_count_to(to)
	else:
		swap_item(to)
	item_slot_selected.remove()
	to.item_slot_selected.add()


func _ready() -> void:
	remove_icon_timer.timeout.connect(empty_item)
	draggable_button.can_drag = has_item
	draggable_button.drag_started.connect(_drag_started)
	draggable_button.drag_ended.connect(_drag_ended)
	if Helpers.is_main_scene(self):
		setup(0)
		set_random_item()


func _process(_delta: float) -> void:
	var is_visible = is_visible_in_tree()
	set_process_input(is_visible)
	if is_visible:
		item_texture_rect.texture = _item_data_count.item.inventory_image if _item_data_count.has_item() else null
		count_label.text = str(_item_data_count.count) if _item_data_count.has_item() else ""
		remove_icon_timer.set_process_input(_item_data_count.has_item() and item_slot_selected.is_shown())


func _on_button_down() -> void:
	item_slot_selected.add()
	click.emit(self)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not get_global_rect().has_point(event.position):
		item_slot_selected.remove()


func _drag_started(is_mouse_right_drag: bool) -> void:
	if _item_data_count.has_item():
		control_dragged.visible = true
		item_dragged.texture = _item_data_count.item.inventory_image
		if is_mouse_right_drag:
			count_label_dragged.text = str(floori(_item_data_count.count * 0.5))
		else:
			count_label_dragged.text = str(_item_data_count.count)


func _drag_ended(_start_mouse_position: Vector2, last_mouse_position: Vector2) -> void:
	control_dragged.visible = false
	if not get_global_rect().has_point(last_mouse_position):
		drag_ended.emit(last_mouse_position, self, draggable_button.is_mouse_right_drag)
