extends LocalizedButton
class_name LocalizedInputButton

@export var show_keyboard_shortcut: bool
@export var inputLabel: InputLabel


func _ready() -> void:
	super._ready()
	inputLabel.input_updated.connect(_input_updated)
	_input_updated(false)


func _input_updated(is_joypad: bool) -> void:
	if not show_keyboard_shortcut:
		inputLabel.visible = false
		return

	var font = get_theme_default_font()
	var font_size = font.get_string_size(tr(text))
	var font_size_override = self["theme_override_font_sizes/font_size"]
	if font_size_override != null:
		font_size *= font_size_override / (float)(get_theme_default_font_size())
	if is_joypad:
		inputLabel.position = Vector2(size.x / 2 - font_size.x / 2 - inputLabel.size.x - 8, size.y / 2 - inputLabel.size.y / 2 - 2)
	else:
		inputLabel.position = Vector2(size.x / 2 - font_size.x / 2 - inputLabel.background.size.x, size.y / 2 - inputLabel.size.y / 2 - 2)
	
