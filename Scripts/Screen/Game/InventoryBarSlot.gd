extends Control
class_name InventoryBarSlot

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var background: NinePatchRect = $Panel/Background
@onready var button: Button = $Panel/Button
@onready var item: TextureRect = $Panel/Item
@onready var input_label: InputLabel = $Panel/InputLabel
@export var default_item_data: ItemData
var current_item_data: ItemData
var slot_index = 0
var selected = false
signal inventory_click(slot_index)

func setup(slotIndex : int):
	slot_index = slotIndex


func set_item_data(item_data: ItemData):
	current_item_data = item_data


func show_animation():
	animation_player.play("Show")
	

func hide_animation():
	animation_player.play("Hide")


func _ready() -> void:
	input_label.set_input(InputMapNames.GAME_INVENTORY_BAR_ + str((slot_index + 1) % 10))
	if get_tree().current_scene == self:
		setup(1)
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
