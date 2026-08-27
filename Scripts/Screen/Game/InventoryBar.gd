extends Control
class_name InventoryBar

@onready var h_box_container: HBoxContainer = $HBoxContainer
@export var inventory_slot: Resource

var slots : Array[InventoryBarSlot]
var selected_character: Character
var _last_selected_index: int = -1

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
				slots[i].item.texture = selected_character.items[i].inventory_image

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


func on_inventory_slot_clicked(_slot_index: int):
	if selected_character != null:
		if _slot_index != selected_character.selected_item_index:
			slots[selected_character.selected_item_index].selected = false
			selected_character.selected_item_index = _slot_index
	else:
		if _last_selected_index != _slot_index:
			slots[_last_selected_index].selected = false
	_last_selected_index = _slot_index


func _ready() -> void:
	for i in 10:
		var slot = inventory_slot.instantiate()
		slot.setup(i)
		slot.inventory_click.connect(on_inventory_slot_clicked)
		slots.append(slot)
		h_box_container.add_child(slot)
		call_deferred("show_slot")

		if get_tree().current_scene == self:
			slot.set_item_data(DataManager.items_data.items[randi() % len(DataManager.items_data.items)])


func show_slot():
	for slot in slots:
		slot.show_animation()


func _process(_delta: float) -> void:
	if selected_character == null:
		var inventory_index = _last_selected_index
		if InputManager.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_LEFT):
			inventory_index = 9 if inventory_index <= 0 else inventory_index - 1
		if InputManager.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_RIGHT):
			inventory_index = 0 if inventory_index >= 9 else inventory_index + 1
		for i in 10:
			if InputManager.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_0.left(len(InputMapNames.GAME_INVENTORY_BAR_0) - 1) + str(i)):
				inventory_index = i - 1 if i != 0 else 9

		if inventory_index != _last_selected_index:
			if _last_selected_index >= 0:
				slots[_last_selected_index].selected = false
			slots[inventory_index].selected = true
			_last_selected_index = inventory_index
	else:
		for i in len(slots):
			if len(selected_character.items) <= i or selected_character.items[i] == null:
				slots[i].set_item_data(null)
			else:
				slots[i].set_item_data(selected_character.items[i])

		if selected_character.selected_item_index >= 0 && selected_character.selected_item_index != _last_selected_index:
			if _last_selected_index >= 0:
				slots[_last_selected_index].selected = false
			slots[selected_character.selected_item_index].selected = true
			_last_selected_index = selected_character.selected_item_index


func _exit_tree() -> void:
	for slot in slots:
		slot.queue_free()
