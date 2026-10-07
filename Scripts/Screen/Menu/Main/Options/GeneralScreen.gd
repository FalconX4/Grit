extends Node
class_name GeneralScreen

@export var language: OptionButton

func _ready() -> void:
	language.clear()
	for locale in Localization.locale_to_string:
		language.add_item(Localization.locale_to_string[locale])
	language.item_selected.connect(_on_language_changed)

func _on_language_changed(index: int) -> void:
	Localization.set_language(Localization.loaded_locales[index])