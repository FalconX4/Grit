extends Button
class_name LocalizedButton

@export var localization_key: LocalizedKey

func _ready() -> void:
	if localization_key.raw_key == tr(localization_key.raw_key):
		Debugger.log_error("No translation found for key: " + localization_key.raw_key)
	else:
		text = localization_key.update_key()
