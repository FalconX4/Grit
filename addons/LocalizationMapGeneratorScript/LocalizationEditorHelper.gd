class_name LocalizationEditorHelper

static var translations: Array[Translation]

static func translate(localization: String) -> String:
	if not translations:
		var locale := TranslationServer.get_tool_locale()
		translations = TranslationServer.find_translations(locale, false)
	for translation in translations:
		var message := translation.get_message(localization)
		if not message.is_empty():
			return message
	return ""
