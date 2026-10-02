extends Node

const KEY = "language"

signal language_changed(old_language: String, new_language: String)

var current_language: String
var loaded_locales: PackedStringArray

func _init() -> void:
	loaded_locales = TranslationServer.get_loaded_locales()
	current_language = SettingManager.get_setting(SettingManager.SECTION, KEY, OS.get_locale_language())
	if not TranslationServer.has_translation_for_locale(current_language, false):
		current_language = loaded_locales[0]
	TranslationServer.set_locale(current_language)

func set_language(language: String) -> void:
	var old_language = current_language
	current_language = language
	TranslationServer.set_locale(current_language)
	SettingManager.set_setting(SettingManager.SECTION, KEY, current_language)
	language_changed.emit(old_language, language)

func translate(key: String) -> String:
	return tr(key)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_released():
		var eventKey = event as InputEventKey
		if eventKey.keycode == KEY_L:
			var locales_len = len(loaded_locales)
			for i in range(len(loaded_locales)):
				if loaded_locales[i] == current_language:
					set_language(loaded_locales[(i+1) % locales_len])
					break
