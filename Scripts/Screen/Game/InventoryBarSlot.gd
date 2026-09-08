extends Control
class_name InventoryBarSlot

@export var animation_player: AnimationPlayer
@export var background: NinePatchRect
@export var button: DraggableButton
@export var item: TextureRect
@export var item_dragged: TextureRect
@export var input_label: InputLabel
@export var default_item_data: ItemData
var current_item_data: ItemData
var slot_index = 0
var selected = false
signal inventory_click(slot_index)
signal drag_ended

func setup(index : int, character_input: CharacterInput = null):
	slot_index = index
	var action = InputMapNames.GAME_INVENTORY_BAR_ + str((index + 1) % 10)
	var input_action = InputMapNames.get_action_input(action)
	input_label.set_input_action(input_action, character_input)


func set_item_data(item_data: ItemData):
	current_item_data = item_data


func show_animation():
	animation_player.play("Show")


func hide_animation():
	animation_player.play("Hide")


func _drag_started():
	if current_item_data != null:
		item_dragged.visible = true
		item_dragged.texture = current_item_data.inventory_image


func _drag_ended(_start_mouse_position: Vector2, last_mouse_position: Vector2):
	item_dragged.visible = false
	if not get_global_rect().has_point(last_mouse_position):
		drag_ended.emit(last_mouse_position, slot_index)


func _ready() -> void:
	button.drag_started.connect(_drag_started)
	button.drag_ended.connect(_drag_ended)
	if Helpers.is_main_scene(self):
		setup(0)
		set_item_data(default_item_data)
		show_animation()


func _process(_delta: float) -> void:
	background.modulate = Color.GREEN if selected else Color.WHITE
	item.texture = current_item_data.inventory_image if current_item_data != null else null


func _on_button_button_down() -> void:
	selected = true
	inventory_click.emit(slot_index)
