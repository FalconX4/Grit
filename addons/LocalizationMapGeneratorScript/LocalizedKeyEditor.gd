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

	var map_names = load(localization_map_script_path).new()
	keys = map_names.LocalizedID.keys()
	for key in keys:
		property_control.add_item(key)

	add_child(property_control)
	add_focusable(property_control)
	refresh_control_text()
	property_control.search_bar_enabled = true
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
	for i in len(keys):
		if current_value == keys[i]:
			property_control.select(i)
	refresh_control_text()
	updating = false


func refresh_control_text():
	property_control.text = current_value
	var edited_object = get_edited_object()
	if edited_object is LocalizedLabel or edited_object is LocalizedButton:
		edited_object.text = current_value
	elif edited_object is LocalizedLineEdit:
		edited_object.placeholder_text = current_value
	elif edited_object is LocalizedConfirmationDialog:
		var edited_property = get_edited_property()
		if edited_property == "localization_key_title":
			edited_object.title = current_value
		elif edited_property == "localization_key_text":
			edited_object.dialog_text = current_value
		elif edited_property == "localization_key_ok":
			edited_object.ok_button_text = current_value
		elif edited_property == "localization_key_cancel":
			edited_object.cancel_button_text = current_value
