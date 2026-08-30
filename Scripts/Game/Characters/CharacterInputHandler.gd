class_name CharacterInputHandler

var input: CharacterInput
var move : Vector2
var inventory = -1
var interact : bool

func _process(_delta: float) -> void:
	move = input.get_vector(InputMapNames.GAME_MOVE_LEFT, InputMapNames.GAME_MOVE_RIGHT, InputMapNames.GAME_MOVE_UP, InputMapNames.GAME_MOVE_DOWN)
	interact = input.is_action_just_pressed(InputMapNames.GAME_INTERACT)
	inventory = InventoryBar.get_inventory_index_from_input(inventory)
