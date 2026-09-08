extends Control
class_name ItemSlot

@export var background: NinePatchRect
@export var button: DraggableButton
@export var item: TextureRect
@export var item_dragged: TextureRect
@export var count_label: Label
@export var selected: ItemSlotSelected
@export var default_item_data: ItemData
var current_item_data_count: ItemDataCount
var _index = 0
signal click(index: int)
signal drag_ended(last_mouse_position: Vector2, index: int)

func setup(index : int):
	_index = index


func set_item(item_data_count: ItemDataCount):
	current_item_data_count = item_data_count


func set_random_item():
	var item_data_count = ItemDataCount.new()
	item_data_count.item = RandomManager.get_array(DataManager.items_data.items)
	item_data_count.count = RandomManager.get_i(100)
	set_item(item_data_count)


func _ready() -> void:
	button.drag_started.connect(_drag_started)
	button.drag_ended.connect(_drag_ended)
	if Helpers.is_main_scene(self):
		setup(0)
		if default_item_data == null:
			set_random_item()
		else:
			var item_data_count = ItemDataCount.new()
			item_data_count.item = default_item_data
			item_data_count.count = RandomManager.get_i(100)
			set_item(item_data_count)


func _process(_delta: float) -> void:
	item.texture = current_item_data_count.item.inventory_image if current_item_data_count != null else null
	count_label.text = str(current_item_data_count.count)


func _on_button_down() -> void:
	selected.add()
	click.emit(_index)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not get_global_rect().has_point(event.position):
		selected.remove()


func _drag_started():
	if current_item_data_count != null:
		item_dragged.visible = true
		item_dragged.texture = current_item_data_count.item.inventory_image


func _drag_ended(_start_mouse_position: Vector2, last_mouse_position: Vector2):
	item_dragged.visible = false
	if not get_global_rect().has_point(last_mouse_position):
		drag_ended.emit(last_mouse_position, _index)
