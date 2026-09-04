extends Label
class_name InputLabel

@export var background: NinePatchRect
@export var input_action: InputMapNames.InputAction = InputMapNames.InputAction.INVALID

var character_input: CharacterInput = null

func _ready() -> void:
	set_input_action(input_action)

func set_input_action(new_input_action: InputMapNames.InputAction, new_character_input: CharacterInput = null) -> void:
	input_action = new_input_action
	character_input = new_character_input
	_update_input()
	if new_character_input == null:
		InputManager.last_input_joypad_changed.disconnect(on_last_input_joypad_changed)
	else:
		InputManager.last_input_joypad_changed.connect(on_last_input_joypad_changed)

func _update_input() -> void:
	var action_id = InputMapNames.get_action_string(input_action)
	if character_input == null:
		text = InputManager.get_action_text(action_id, InputManager._last_device_type)
	else:
		var device_action_id = character_input.get_device_action_id(action_id)
		var device_type = character_input.get_device_type()
		text = InputManager.get_action_text(device_action_id, device_type)

	if text == action_id:
		text = ""
		background.visible = false
	else:
		background.visible = !InputManager._last_input_joypad

func on_last_input_joypad_changed(_value: bool) -> void:
	_update_input()
