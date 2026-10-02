extends LocalizedButton
class_name LocalizedInputButton

@export var inputLabel: InputLabel

func _ready() -> void:
	super._ready()
	inputLabel.input_updated.connect(_input_updated)
	_input_updated(false)

func _input_updated(is_joypad: bool) -> void:
	var font = get_theme_font("font")
	var font_size = font.get_string_size(tr(text))
	if is_joypad:
		inputLabel.position = Vector2(size.x / 2 - font_size.x / 2 - inputLabel.size.x - 8, size.y / 2 - inputLabel.size.y / 2 - 2)
		Debugger.log(is_joypad, inputLabel.size)
	else:
		inputLabel.position = Vector2(size.x / 2 - font_size.x / 2 - inputLabel.background.size.x, size.y / 2 - inputLabel.size.y / 2 - 2)
		Debugger.log(is_joypad, inputLabel.size)
