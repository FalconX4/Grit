class_name CharacterInputHandler

var input: CharacterInput
var move : Vector2
var inventory = -1
var interact : bool

func _process(_delta: float) -> void:
	inventory = -1
	move = input.get_vector(InputMapNames.GAME_MOVE_LEFT, InputMapNames.GAME_MOVE_RIGHT, InputMapNames.GAME_MOVE_UP, InputMapNames.GAME_MOVE_DOWN)
	interact = input.is_action_just_pressed(InputMapNames.GAME_INTERACT)
	if input.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_LEFT):
		inventory = 9 if inventory <= 0 else inventory - 1
	if input.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_RIGHT):
		inventory = 0 if inventory >= 9 else inventory + 1
	for i in 10:
		if input.is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_0.left(len(InputMapNames.GAME_INVENTORY_BAR_0) - 1) + str(i)):
			inventory = i - 1 if i != 0 else 9
