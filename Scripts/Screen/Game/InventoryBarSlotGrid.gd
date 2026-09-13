extends ItemSlotGrid
class_name InventoryBarSlotGrid

func get_new_index_from_input(last_index: int, event: InputEvent, character_input: CharacterInput = null) -> int:
	if character_input.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_LEFT, event):
		return columns - 1 if last_index <= 0 else last_index - 1
	if character_input.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_RIGHT, event):
		return 0 if last_index >= columns - 1 else last_index + 1
	for i in columns:
		if character_input.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_ + str(i), event):
			return i - 1 if i != 0 else 9
	return last_index
