extends Label
class_name InputLabel

@onready var background: NinePatchRect = $Background
@export var input_action: InputMapNames.InputAction = InputMapNames.InputAction.INVALID

func _ready() -> void:
	InputManager.last_input_joypad_changed.connect(on_last_input_joypad_changed)
	set_input(InputMapNames.get_action_string(input_action))

func set_input_action(new_input_action: InputMapNames.InputAction) -> void:
	input_action = new_input_action
	_update_input(InputMapNames.get_action_string(input_action))

func set_input(action_id: String) -> void:
	input_action = InputMapNames.get_action_input(action_id)
	_update_input(action_id)

func _update_input(action_id: String) -> void:
	text = InputManager.get_action_text(action_id, InputManager._last_device_type)
	if text == action_id:
		text = ""
		background.visible = false
	else:
		background.visible = !InputManager._last_input_joypad

func on_last_input_joypad_changed(_value: bool) -> void:
	set_input(InputMapNames.get_action_string(input_action))
