@tool
extends EditorInspectorPlugin

var LocalizedKeyEditor = preload("res://addons/LocalizationMapGeneratorScript/LocalizedKeyEditor.gd")

func _can_handle(object: Object) -> bool:
	return object is LocalizedLabel

func _parse_property(object: Object, type: int, path: String, hint: int, hint_text: String, usage: int, wide: bool) -> bool:
	if path == "localization_key":
		add_property_editor(path, LocalizedKeyEditor.new())
		return true
	return false
