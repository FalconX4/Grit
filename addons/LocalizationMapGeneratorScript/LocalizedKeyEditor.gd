extends EditorProperty

var localization_map_script_path = "res://Scripts/Helper/LocalizationMapNames.gd"
var property_control = OptionButton.new()
var current_value = ""
var updating = false

var keys = []

func _init():
	if not FileAccess.file_exists(localization_map_script_path):
		var label = Label.new()
		label.modulate = Color(1, 0, 0)
		label.text = "Press Generate localization map"
		add_child(label)
		return

	var mapNames = load(localization_map_script_path).new()
	keys = mapNames.LocalizedID.keys()
	for key in keys:
		property_control.add_item(key)

	add_child(property_control)
	add_focusable(property_control)
	refresh_control_text()
	property_control.item_selected.connect(_on_item_selected)


func _on_item_selected(index: int) -> void:
	if (updating):
		return

	current_value = keys[index]
	refresh_control_text()
	emit_changed(get_edited_property(), current_value)


func _update_property():
	var new_value = get_edited_object()[get_edited_property()]
	if new_value == current_value:
		return

	updating = true
	current_value = new_value
	refresh_control_text()
	updating = false


func refresh_control_text():
	property_control.text = current_value
	print("Refreshing control text to: %s %s %s" % [current_value, tr(current_value), TranslationServer.translate(current_value)])
	var editor_object = get_edited_object() as LocalizedLabel
	if editor_object != null:
		editor_object.text = TranslationServer.translate(current_value)
