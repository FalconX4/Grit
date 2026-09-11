extends Control
class_name InventoryBar

@export var item_slot_grid: ItemSlotGrid

var selected_character: Character

func set_character(character: Character, doAnimations: bool):
	selected_character = character
	if selected_character == null:
		if doAnimations:
			hide_animation()
	else:
		var lenItems = len(selected_character.inventory_bar)
		for i in len(item_slot_grid.slots):
			(item_slot_grid.slots[i] as InventoryBarSlot).setup(i, selected_character.character_input)
			if i >= lenItems:
				item_slot_grid.slots[i].empty_item()
			else:
				item_slot_grid.slots[i].set_item(selected_character.inventory_bar[i])

		if doAnimations:
			show_animation()


func show_animation():
	Helpers.node_enable(self)
	for slot in item_slot_grid.slots:
		slot.show_animation()
func hide_animation():
	Helpers.node_disable(self)
	for slot in item_slot_grid.slots:
		slot.hide_animation()
func show_slot_animation(index : int):
	Helpers.node_enable(self)
	item_slot_grid.slots[index].show_animation()
func hide_slot_animation(index : int):
	item_slot_grid.slots[index].hide_animation()
	var all_hiding_or_hidden = true
	for slot in item_slot_grid.slots:
		if not (slot as InventoryBarSlot).is_hiding_or_hidden:
			all_hiding_or_hidden = false
			break
	if all_hiding_or_hidden:
		Helpers.node_disable(self)


func on_inventory_slot_clicked(_slot_index: int):
	if selected_character != null:
		if _slot_index != selected_character.inventory_bar_selected_index:
			selected_character.inventory_bar_selected_index = _slot_index


func _ready() -> void:
	if Helpers.is_main_scene(self):
		set_random_items()

	for slot in item_slot_grid.slots:
		slot.click.connect(on_inventory_slot_clicked)

	show_animation()
	call_deferred("_after_ready")


func _after_ready() -> void:
	var old_size = size
	size = item_slot_grid.size
	position -= (size - old_size) * 0.5

var _last_selected_index = -1
func _process(_delta: float) -> void:
	if selected_character == null:
		var inventory_index = get_inventory_bar_index_from_input(_last_selected_index)
		if inventory_index != _last_selected_index:
			if _last_selected_index >= 0:
				item_slot_grid.slots[_last_selected_index].item_slot_selected.remove()
			item_slot_grid.slots[inventory_index].item_slot_selected.add()
			_last_selected_index = inventory_index
	else:
		var selected_index = selected_character.input_handler.inventory_bar_selected_index
		if selected_index >= 0 && selected_index != _last_selected_index:
			if _last_selected_index >= 0:
				item_slot_grid.slots[_last_selected_index].item_slot_selected.remove()
			item_slot_grid.slots[selected_index].item_slot_selected.add()
			_last_selected_index = selected_index


func set_random_items() -> void:
	for slot in item_slot_grid.slots:
		slot.set_random_item()



static func get_inventory_bar_index_from_input(last_index: int, character_input: CharacterInput = null) -> int:
	var left_device_action_id = character_input.get_device_action_id(InputMapNames.GAME_INVENTORY_BAR_LEFT) if character_input != null else str(InputMapNames.GAME_INVENTORY_BAR_LEFT)
	var right_device_action_id = character_input.get_device_action_id(InputMapNames.GAME_INVENTORY_BAR_RIGHT) if character_input != null else str(InputMapNames.GAME_INVENTORY_BAR_RIGHT)
	if left_device_action_id != "" and InputManager.is_action_just_pressed(left_device_action_id):
		return 9 if last_index <= 0 else last_index - 1
	if right_device_action_id != "" and InputManager.is_action_just_pressed(right_device_action_id):
		return 0 if last_index >= 9 else last_index + 1
	for i in 10:
		var inventory_action_id = InputMapNames.GAME_INVENTORY_BAR_ + str(i)
		var inventory_device_action_id = character_input.get_device_action_id(inventory_action_id) if character_input != null else inventory_action_id
		if inventory_device_action_id != "" and InputManager.is_action_just_pressed(inventory_device_action_id):
			return i - 1 if i != 0 else 9
	return last_index
