extends Control
class_name Inventory

const INVENTORY_SLOT = preload("res://Scenes/Screen/Game/InventorySlot.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer

var slots : Array[InventorySlot]
var selected_character: Character


func set_character(character: Character, doAnimations: bool):
	selected_character = character
	if selected_character == null:
		if doAnimations:
			hide_animation()
	else:
		var lenItems = len(selected_character.items)
		for i in len(slots):
			if i >= lenItems:
				slots[i].item.texture = null
			else:
				slots[i].item.texture = selected_character.items[i].inventory_bar_image

		if doAnimations:
			show_animation()

func show_animation():
	for slot in slots:
		slot.show_animation()
func hide_animation():
	for slot in slots:
		slot.hide_animation()
func show_slot_animation(index : int):
	slots[index].show_animation()
func hide_slot_animation(index : int):
	slots[index].hide_animation()
	
func on_inventory_slot_clicked(slot_index: int):
	if selected_character != null:
		for i in len(slots):
			if slots[i].selected and i != selected_character.selected_item_index:
				slots[selected_character.selected_item_index].selected = false
				selected_character.selected_item_index = i

func _ready() -> void:
	for i in 10:
		var slot = INVENTORY_SLOT.instantiate()
		slot.setup(i)
		slot.inventory_click.connect(on_inventory_slot_clicked)
		slots.append(slot)
		h_box_container.add_child(slot)


func _process(_delta: float) -> void:
	if selected_character != null:
		for i in len(slots):
			if len(selected_character.items) <= i or selected_character.items[i] == null:
				slots[i].item.texture = null
			else:
				slots[i].item.texture = selected_character.items[i].inventory_bar_image
				
		if selected_character.selected_item_index >= 0:
			for i in len(slots):
				slots[i].selected = false
			slots[selected_character.selected_item_index].selected = true


func _exit_tree() -> void:
	for slot in slots:
		slot.queue_free()
