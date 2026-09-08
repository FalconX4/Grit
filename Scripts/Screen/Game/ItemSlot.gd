extends Control
class_name ItemSlot

@export var background: NinePatchRect
@export var button: DraggableButton
@export var item: TextureRect
@export var item_dragged: TextureRect
@export var selected: ItemSlotSelected
@export var default_item_data: ItemData
var current_item_data: ItemData
var _index = 0
signal click(index: int)
signal drag_ended(last_mouse_position: Vector2, index: int)

func setup(index : int):
	_index = index


func set_item_data(item_data: ItemData):
	current_item_data = item_data


func set_random_item_data():
	set_item_data(RandomManager.get_array(DataManager.items_data.items))


func _ready() -> void:
	button.drag_started.connect(_drag_started)
	button.drag_ended.connect(_drag_ended)
	if Helpers.is_main_scene(self):
		setup(0)
		set_item_data(default_item_data)


func _process(_delta: float) -> void:
	item.texture = current_item_data.inventory_image if current_item_data != null else null


func _on_button_down() -> void:
	selected.add()
	click.emit(_index)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not get_global_rect().has_point(event.position):
		selected.remove()


func _drag_started():
	if current_item_data != null:
		item_dragged.visible = true
		item_dragged.texture = current_item_data.inventory_image


func _drag_ended(_start_mouse_position: Vector2, last_mouse_position: Vector2):
	item_dragged.visible = false
	if not get_global_rect().has_point(last_mouse_position):
		drag_ended.emit(last_mouse_position, _index)
