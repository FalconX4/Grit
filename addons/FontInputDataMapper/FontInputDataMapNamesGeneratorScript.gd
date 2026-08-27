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

const mapping: Dictionary[DeviceIdMapNames.DeviceId, Array] = {
%s
}

static func get_button(device_id: DeviceIdMapNames.DeviceId, button_id: int) -> String:
	return mapping[device_id][MappingEnum.BUTTONS][button_id]

static func get_axis(device_id: DeviceIdMapNames.DeviceId, axis_id: int) -> String:
	return mapping[device_id][MappingEnum.AXIS][axis_id]

static func input_to_text(event: InputEvent, device_id_enum: DeviceIdMapNames.DeviceId) -> String:
	if event is InputEventJoypadButton:
		return FontInputDataMapNames.get_button(device_id_enum, event.button_index)
	elif event is InputEventJoypadMotion:
		return FontInputDataMapNames.get_axis(device_id_enum, event.axis)
	elif event is InputEventMouseButton:
		return FontInputDataMapNames.get_button(device_id_enum, event.button_index)
	return str(event.button_index)
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
			result += "\tDeviceIdMapNames.DeviceId.%s: [ %sMapNames.mapping_button, %sMapNames.mapping_axis ],\n" % [ FontInputDataRange.get_input_string_helper(DeviceIdMapNames.DeviceId, font_input_data.device_id, ""), value.get_basename(), value.get_basename() ]
	return result
