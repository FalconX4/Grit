extends Label
class_name LocalizedLabel

@export var localization_key: String

func _ready() -> void:
	if localization_key == tr(localization_key):
		Debugger.log_error("No translation found for key: " + localization_key)
	else:
		text = localization_key
