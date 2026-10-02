extends Label
class_name InputLabel

@export var background: NinePatchRect
@export var input_action: InputMapNames.InputAction = InputMapNames.InputAction.INVALID

signal action_pressed(character_input: CharacterInput)
signal input_updated(is_joypad: bool)

var character_input: CharacterInput = null
var action_id: String

func _ready() -> void:
	InputManager.last_input_joypad_changed.connect(on_last_input_joypad_changed)
	set_input_action(input_action)
	if not input_updated.has_connections():
		reset_size()

func set_character_input(new_character_input: CharacterInput) -> void: set_input_action(input_action, new_character_input)
func set_input_action(new_input_action: InputMapNames.InputAction, new_character_input: CharacterInput = null) -> void:
	input_action = new_input_action
	character_input = new_character_input
	_update_input()

func _update_input() -> void:
	action_id = InputMapNames.get_action_string(input_action)
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

	if input_updated.has_connections():
		reset_size()
		input_updated.emit(InputManager._last_input_joypad)

func on_last_input_joypad_changed(_value: bool) -> void:
	_update_input()

func _input(event: InputEvent) -> void:
	if character_input and character_input.is_action_just_pressed(action_id, event):
		action_pressed.emit(character_input)
