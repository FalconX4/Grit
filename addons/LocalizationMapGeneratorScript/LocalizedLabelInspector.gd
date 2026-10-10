@tool
extends EditorInspectorPlugin

var LocalizedKeyEditor = preload("res://addons/LocalizationMapGeneratorScript/LocalizedKeyEditor.gd")

func _can_handle(object: Object) -> bool:
	return object is LocalizedLabel or LocalizedButton or LocalizedLineEdit or LocalizedConfirmationDialog

func _parse_property(object: Object, type: int, path: String, hint: int, hint_text: String, usage: int, wide: bool) -> bool:
	if object is LocalizedConfirmationDialog:
		if path == "localization_key_title" or path == "localization_key_text" or path == "localization_key_ok" or path == "localization_key_cancel":
			add_property_editor(path, LocalizedKeyEditor.new())
			return true
	elif path == "localization_key":
		add_property_editor(path, LocalizedKeyEditor.new())
		return true
	return false
