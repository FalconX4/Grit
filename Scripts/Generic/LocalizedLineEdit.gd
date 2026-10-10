extends LineEdit
class_name LocalizedLineEdit

@export var localization_key: String

func _ready() -> void:
	if localization_key == tr(localization_key):
		Debugger.log_error("No translation found for key: " + localization_key)
	else:
		placeholder_text = localization_key
