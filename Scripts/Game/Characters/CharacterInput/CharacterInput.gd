extends Node
class_name CharacterInput

@export var is_player : bool
var move : Vector2
var inventory = -1
var interact : bool
var was_using_controller : bool
var using_controller : bool

func _process(_delta: float) -> void:
	inventory = -1
	move = get_vector(InputMapNames.GAME_MOVE_LEFT, InputMapNames.GAME_MOVE_RIGHT, InputMapNames.GAME_MOVE_UP, InputMapNames.GAME_MOVE_DOWN)
	interact = is_action_just_pressed(InputMapNames.GAME_INTERACT)
	if is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_LEFT):
		inventory = 9 if inventory <= 0 else inventory - 1
	if is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_RIGHT):
		inventory = 0 if inventory >= 9 else inventory + 1
	for i in 10:
		if is_action_just_pressed(InputMapNames.GAME_INVENTORY_BAR_0.left(len(InputMapNames.GAME_INVENTORY_BAR_0) - 1) + str(i)):
			inventory = i - 1 if i != 0 else 9

func is_action_just_pressed(_action_id: String) -> bool:
	return false

func get_vector(_left: String, _right: String, _up: String, _down: String) -> Vector2:
	return Vector2.ZERO
