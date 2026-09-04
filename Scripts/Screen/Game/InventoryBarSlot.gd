extends Control
class_name InventoryBarSlot

@export var animation_player: AnimationPlayer
@export var background: NinePatchRect
@export var button: Button
@export var item: TextureRect
@export var input_label: InputLabel
@export var default_item_data: ItemData
var current_item_data: ItemData
var slot_index = 0
var selected = false
signal inventory_click(slot_index)


func setup(slotIndex : int, character_input: CharacterInput = null):
	slot_index = slotIndex
	var action = InputMapNames.GAME_INVENTORY_BAR_ + str((slot_index + 1) % 10)
	var input_action = InputMapNames.get_action_input(action)
	input_label.set_input_action(input_action, character_input)


func set_item_data(item_data: ItemData):
	current_item_data = item_data


func show_animation():
	animation_player.play("Show")


func hide_animation():
	animation_player.play("Hide")


func _ready() -> void:
	if get_tree().current_scene == self:
		setup(0)
		set_item_data(default_item_data)
		show_animation()


func _process(_delta: float) -> void:
	background.modulate = Color.GREEN if selected else Color.WHITE
	item.texture = current_item_data.inventory_image if current_item_data != null else null


func _on_button_button_down() -> void:
	selected = true
	inventory_click.emit(slot_index)


func _input(event: InputEvent) -> void:
	if get_tree().current_scene == self:
		if event is InputEventKey:
			pass
