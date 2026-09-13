extends CharacterInput
class_name PlayerInput

var joypad: InputManager.JoypadData

func set_device_id(id : int) -> void:
	using_controller = true
	joypad = InputManager.get_joypad(id)


func get_device_type() -> DeviceTypeMapNames.DeviceType:
	if using_controller:
		return joypad.device_type
	else:
		return DeviceTypeMapNames.DeviceType.KEYBOARD


func get_device_action_id(action_id: String) -> String:
	if using_controller:
		return joypad.buttons[action_id] if joypad.buttons.has(action_id) else ""
	else:
		return InputManager.keyboard_buttons[action_id] if InputManager.keyboard_buttons.has(action_id) else ""


func is_action_just_pressed(action_id: String, event: InputEvent = null) -> bool:
	var device_action_id = get_device_action_id(action_id)
	if device_action_id == "":
		return false
	elif event == null:
		return Input.is_action_just_pressed(device_action_id)
	else:
		return Input.is_action_just_pressed_by_event(device_action_id, event)


func get_vector(left: String, right: String, up: String, down: String) -> Vector2:
	return Input.get_vector(get_device_action_id(left), get_device_action_id(right), get_device_action_id(up), get_device_action_id(down))
