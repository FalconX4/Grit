class_name CharacterInputHandler

var input: CharacterInput
var move : Vector2
var inventory_bar_selected_index = -1
var interact : bool

signal on_inventory_bar_index_changed(old_index: int, new_index: int)

func _process(_delta: float) -> void:
	move = input.get_vector(InputMapNames.GAME_MOVE_LEFT, InputMapNames.GAME_MOVE_RIGHT, InputMapNames.GAME_MOVE_UP, InputMapNames.GAME_MOVE_DOWN)
	interact = input.is_action_just_pressed(InputMapNames.GAME_INTERACT)
	inventory_bar_selected_index = InventoryBar.get_inventory_bar_index_from_input(inventory_bar_selected_index, input)
