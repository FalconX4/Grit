class_name Helpers

static func controller_input_to_text(event: InputEvent, devide_id: int) -> String:
	if event is InputEventJoypadButton:
		match Input.get_joy_name(devide_id):
			"XInput Gamepad": return xbox_input_text(event)
			"PS4 Controller": return ps_input_text(event)
			_: return str(event.button_index)
	return ""

static func xbox_input_text(event: InputEvent) -> String:
	match event.button_index:
		0: return "A"
		_: return str(event.button_index)

static func ps_input_text(event: InputEvent) -> String:
	match event.button_index:
		0: return "X"
		_: return str(event.button_index)

static func switch_input_text(event: InputEvent) -> String:
	match event.button_index:
		0: return "B"
		_: return str(event.button_index)
