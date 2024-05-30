extends Control
class_name InventorySlot

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var background: NinePatchRect = $Panel/Background
@onready var button: Button = $Panel/Button
@onready var item: TextureRect = $Panel/Item
@onready var label: Label = $Panel/Label
var slot_index = 0
var selected = false
signal inventory_click(slot_index)

func setup(slotIndex : int):
	slot_index = slotIndex

func show_animation():
	animation_player.play("Show")
	
func hide_animation():
	animation_player.play("Hide")

func _ready() -> void:
	label.text = str((slot_index + 1) % 10)


func _process(_delta: float) -> void:
	background.modulate = Color.GREEN if selected else Color.WHITE 


func _on_button_button_down() -> void:
	selected = true
	inventory_click.emit(slot_index)
