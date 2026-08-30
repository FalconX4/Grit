@tool
extends Resource
class_name FontInputData

@export var font : Font
@export var device_type : DeviceTypeMapNames.DeviceType
@export var font_ranges: Array[FontInputDataRange] = []

@export_tool_button("Update Generated Script", "Reload") var update_generated_script_action: Callable = update_generated_script

const script_path: String = "res://Scripts/Helper/FontInputData/%sMapNames.gd"
const generated_script_template: String = "extends RefCounted
class_name %sMapNames
# Auto generated class by ControllerFontData

const mapping_button: Dictionary[int, String] = {
%s
}

const mapping_axis: Dictionary[int, String] = {
%s
}
"

func update_generated_script() -> void:
	print("Beginning input map script generation")
	if font == null:
		push_error("Cannot update null font")

	set_character_range()
	var file_path = create_file()
	print("Finished generating input map script at: %s" % file_path)


func set_character_range() -> void:
	var character_ranges: PackedStringArray = []
	for font_range in font_ranges:
		character_ranges.append("'%s' %s" % [char(font_range.character.hex_to_int()), font_range.range])

	var font_data = font.resource_path + ".import"
	var config := ConfigFile.new()
	config.load(font_data)
	config.set_value("params", "character_ranges", character_ranges)
	config.set_value("params", "columns", len(font_ranges))
	config.save(font_data)


func create_file() -> String:
	var file_name = self.resource_path.get_file().get_basename()
	var generated_script = generated_script_template % [ file_name, get_inputs_to_character(true, false), get_inputs_to_character(false, true)]
	var file_path = script_path % file_name
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(generated_script)
	EditorInterface.get_resource_filesystem().update_file(file_path)
	return file_path


func get_inputs_to_character(check_buttons: bool, check_axis: bool) -> String:
	var result = ""
	for font_range in font_ranges:
		var range_data = font_range as FontInputDataRange
		if (check_buttons and range_data.is_button()) or (check_axis and range_data.is_axis()):
			result += "\t%s: '%s',\n" % [range_data.get_value_string(), char(font_range.character.hex_to_int())]
	return result
