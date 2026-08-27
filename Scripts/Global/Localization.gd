extends Node


const KEY = "Language"

var current_language: String
var loaded_locales: PackedStringArray

func _init() -> void:
	loaded_locales = TranslationServer.get_loaded_locales()
	current_language = OS.get_locale_language()
	if not TranslationServer.has_translation_for_locale(current_language, false):
		current_language = loaded_locales[0]


func _ready() -> void:
	current_language = SettingManager.get_setting(SettingManager.SECTION, KEY, current_language)
	TranslationServer.set_locale(current_language)


func set_language(language: String) -> void:
	current_language = language
	TranslationServer.set_locale(current_language)
	SettingManager.set_setting(SettingManager.SECTION, KEY, current_language)
