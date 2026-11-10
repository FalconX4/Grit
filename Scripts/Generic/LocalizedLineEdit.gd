extends LineEdit
class_name LocalizedLineEdit

@export var localization_key: LocalizedKey = LocalizedKey.new()

func _ready() -> void:
	if localization_key.raw_key == tr(localization_key.raw_key):
		Debugger.log_error("No translation found for key: " + localization_key.raw_key)
	else:
		placeholder_text = localization_key.update_key()
