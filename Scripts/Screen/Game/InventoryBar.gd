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
			slots[i].setup(i, selected_character.character_input)
			if i >= lenItems:
				slots[i].set_item_data(null)
			else:
				slots[i].set_item_data(selected_character.items[i])

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
		show_slot()

		if get_tree().current_scene == self:
			slot.set_item_data(DataManager.items_data.items[randi() % len(DataManager.items_data.items)])

	call_deferred("_after_ready")


func _after_ready() -> void:
	var old_size = size
	size = h_box_container.size
	position -= (size - old_size) * 0.5


func show_slot():
	for slot in slots:
		slot.show_animation()


static func get_inventory_index_from_input(last_index: int, character_input: CharacterInput = null) -> int:
	var left_device_action_id = character_input.get_device_action_id(InputMapNames.GAME_INVENTORY_BAR_LEFT) if character_input != null else str(InputMapNames.GAME_INVENTORY_BAR_LEFT)
	var right_device_action_id = character_input.get_device_action_id(InputMapNames.GAME_INVENTORY_BAR_RIGHT) if character_input != null else str(InputMapNames.GAME_INVENTORY_BAR_RIGHT)
	if InputManager.is_action_just_pressed(left_device_action_id):
		return 9 if last_index <= 0 else last_index - 1
	if InputManager.is_action_just_pressed(right_device_action_id):
		return 0 if last_index >= 9 else last_index + 1
	for i in 10:
		var inventory_action_id = InputMapNames.GAME_INVENTORY_BAR_ + str(i)
		var inventory_device_action_id = character_input.get_device_action_id(inventory_action_id) if character_input != null else inventory_action_id
		if InputManager.is_action_just_pressed(inventory_device_action_id):
			return i - 1 if i != 0 else 9
	return last_index


func _process(_delta: float) -> void:
	if selected_character == null:
		var inventory_index = get_inventory_index_from_input(_last_selected_index)
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
