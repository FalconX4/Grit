extends Node
class_name CharacterInput

@export var is_player : bool
var was_using_controller : bool
var using_controller : bool

func is_action_just_pressed(_action_id: String) -> bool:
	return false

func get_vector(_left: String, _right: String, _up: String, _down: String) -> Vector2:
	return Vector2.ZERO
