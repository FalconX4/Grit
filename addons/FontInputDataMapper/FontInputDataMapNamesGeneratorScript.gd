@tool
extends EditorPlugin

const data_path: String = "res://addons/FontInputDataMapper/Data/"
const script_path: String = "res://Scripts/Helper/FontInputData/FontInputDataMapNames.gd"
const generated_script_template: String = "class_name FontInputDataMapNames
# Auto generated class by FontInputDataMapNamesGeneratorScript

enum MappingEnum
{
	BUTTONS,
	AXIS
}

const mapping: Dictionary[DeviceTypeMapNames.DeviceType, Array] = {
%s
}

static func get_button(device_type: DeviceTypeMapNames.DeviceType, button_id: int) -> String:
	return mapping[device_type][MappingEnum.BUTTONS][button_id]

static func get_axis(device_type: DeviceTypeMapNames.DeviceType, axis_id: JoyAxis, value: float) -> String:
	var axis_extended = JoypadMapEnum.get_axis_extended(axis_id, value)
	return mapping[device_type][MappingEnum.AXIS][axis_extended]

static func input_to_text(event: InputEvent, device_type: DeviceTypeMapNames.DeviceType) -> String:
	if event is InputEventMouseButton:
		return get_button(device_type, event.button_index)
	elif event is InputEventJoypadButton:
		return get_button(device_type, event.button_index)
	elif event is InputEventJoypadMotion:
		return get_axis(device_type, event.axis, event.axis_value)
	elif event is InputEventKey:
		return get_keyboard_localized(event.physical_keycode if event.physical_keycode != 0 else event.keycode)
	return event.as_text()

static func get_keyboard_localized(keycode: int) -> String:
	if keycode == 0:
		return \"\"
	var os_keycode = OS.get_keycode_string(keycode)
	if os_keycode.is_empty():
		return \"\"
	var key: String = \"KEY_%%s\" %% os_keycode.strip_edges().replace(\" \", \"_\").to_upper()
	var key_translated: String = TranslationServer.translate(key)
	if key_translated != key:
		return key_translated
	return os_keycode
"

func _enter_tree() -> void:
	add_tool_menu_item("Generate Font Input Map", _on_button_pressed)

func _exit_tree():
	remove_tool_menu_item("Generate Font Input Map")

func _on_button_pressed() -> void:
	print("Beginning font input map script generation")
	var generated_script = generated_script_template % [ get_value(data_path) ]
	var file = FileAccess.open(script_path, FileAccess.WRITE)
	file.store_string(generated_script)
	EditorInterface.get_resource_filesystem().update_file(script_path)
	print("Finished font generating input map script at: %s" % script_path)

func get_value(path: String) -> String:
	var result = ""
	var values = ResourceLoader.list_directory(path)
	for value in values:
		if value == "" or value == null:
			continue
		elif value.ends_with('/'):
			get_value(path + value)
		else:
			var font_input_data = ResourceLoader.load(path + value) as FontInputData
			font_input_data.update_generated_script()
			result += "\tDeviceTypeMapNames.DeviceType.%s: [ %sMapNames.mapping_button, %sMapNames.mapping_axis ],\n" % [ FontInputDataRange.get_input_string_helper(DeviceTypeMapNames.DeviceType, font_input_data.device_type, ""), value.get_basename(), value.get_basename() ]
	return result
