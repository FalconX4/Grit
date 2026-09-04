extends Node
class_name CharacterInput

@export var is_player : bool
var was_using_controller : bool
var using_controller : bool

func get_device_type() -> DeviceTypeMapNames.DeviceType:
	return DeviceTypeMapNames.DeviceType.INVALID


func get_device_action_id(action_id: String) -> String:
	return action_id

func is_action_just_pressed(_action_id: String) -> bool:
	return false

func get_vector(_left: String, _right: String, _up: String, _down: String) -> Vector2:
	return Vector2.ZERO
