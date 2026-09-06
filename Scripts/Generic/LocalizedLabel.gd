extends Label
class_name LocalizedLabel

@export var localization_key: String

func _ready() -> void:
	if localization_key != "":
		text = localization_key
