@tool
extends EditorInspectorPlugin

var LocalizedKeyEditor = preload("res://addons/LocalizationMapGeneratorScript/LocalizedKeyEditor.gd")

var object_edited: Object
var property_edited: String
var found_localized_key: Array[LocalizedKey]

func _can_handle(object: Object) -> bool:
	return object is LocalizedLabel or LocalizedButton or LocalizedLineEdit or LocalizedConfirmationDialog or LocalizedKey

func _parse_begin(object: Object) -> void:
	if object is not LocalizedKey:
		object_edited = object

func _parse_property(object: Object, type: int, path: String, hint: int, hint_text: String, usage: int, wide: bool) -> bool:
	if object is LocalizedKey:
		if path == "raw_key":
			var editor = LocalizedKeyEditor.new()
			editor.set_meta("object_edited", object_edited)
			editor.set_meta("property_edited", property_edited)
			add_property_editor(path, editor)
			return true
	else:
		property_edited = path
	return false
