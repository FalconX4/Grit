extends CharacterInput
class_name PlayerInput

var joypad: InputManager.JoypadData

func set_device_id(id : int) -> void:
	joypad = InputManager.get_joypad(id)


func _input(event: InputEvent) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		was_using_controller = using_controller
		using_controller = event is InputEventJoypadButton or event is InputEventJoypadMotion
		if using_controller:
			set_device_id(event.device)


func get_device_type() -> DeviceTypeMapNames.DeviceType:
	if joypad != null:
		return joypad.device_type
	else:
		return DeviceTypeMapNames.DeviceType.KEYBOARD


func get_device_action_id(action_id: String) -> String:
	if using_controller:
		return joypad.buttons[action_id] if joypad.buttons.has(action_id) else ""
	else:
		return InputManager.keyboard_buttons[action_id] if InputManager.keyboard_buttons.has(action_id) else ""


func is_action_just_pressed(action_id: String) -> bool:
	var device_action_id = get_device_action_id(action_id)
	return Input.is_action_just_pressed(device_action_id) if device_action_id != "" else false


func get_vector(left: String, right: String, up: String, down: String) -> Vector2:
	return Input.get_vector(get_device_action_id(left), get_device_action_id(right), get_device_action_id(up), get_device_action_id(down))
