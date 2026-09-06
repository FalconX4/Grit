@tool
extends EditorPlugin

const ignored_files: Array[String] = [
	"Keyboard"
]

const folder_path: String = "res://Scripts/Helper/"
const script_path: String = folder_path + "LocalizationMapNames.gd"
const generated_script_template: String = "class_name LocalizationMapNames
# Auto generated class made by LocalizationMapGeneratorScript

enum LocalizedID {
	INVALID = -1,
%s
}

%s

static func enum_to_string(id: int) -> StringName:
	match id:
%s
		_:
			return \"INVALID\"

static func string_to_enum(id: StringName) -> int:
	match id:
%s
		_:
			return LocalizedID.INVALID

static func get_all_actions() -> Array[StringName]:
	return [
%s
]
"

var inspector_plugin

func _enter_tree() -> void:
	inspector_plugin = preload("res://addons/LocalizationMapGeneratorScript/LocalizedLabelInspector.gd").new()
	print("Adding inspector plugin: %s" % inspector_plugin)
	add_inspector_plugin(inspector_plugin)
	add_tool_menu_item("Generate Localization Map", _on_button_pressed)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)
	remove_tool_menu_item("Generate Localization Map")

func _on_button_pressed() -> void:
	print("Beginning localization map script generation")
	DirAccess.remove_absolute(folder_path)
	DirAccess.make_dir_absolute(folder_path)

	var keys = localization_keys()
	var generated_script = generated_script_template % [
		get_localization_enum(keys),
		get_localization_constants(keys),
		get_localization_match_cases(keys),
		get_string_match_cases(keys),
		get_localization_array(keys)]
	var created_file = FileAccess.open(script_path, FileAccess.WRITE)
	created_file.store_string(generated_script)
	EditorInterface.get_resource_filesystem().update_file(script_path)
	print("Generated localization map script at: %s" % script_path)
	print("Finished localization map script generation")

func localization_keys() -> PackedStringArray:
	var keys: PackedStringArray = []
	
	var files: PackedStringArray = []
	for localization in TranslationServer.get_translations():
		var remove_count = len(".") + len(localization.locale) + len(".translation")
		var file = localization.resource_path.erase(len(localization.resource_path) - remove_count, remove_count) + ".csv"
		var file_name = file.get_file().get_basename()
		if not file in files and not file_name in ignored_files:
			files.append(file)
			var csv := FileAccess.open(file, FileAccess.READ)
			if csv:
				var header := csv.get_csv_line(";")
				while not csv.eof_reached():
					var row := csv.get_csv_line(";")
					if row.size() > 0 and not row[0].is_empty():
						if row[0] not in keys:
							keys.append(row[0])
	return keys


func get_localization_enum(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "\t%s,\n" % [key.to_upper()]
	return result


func get_localization_constants(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "const %s: StringName = &\"%s\"\n" % [key.to_upper(), key]
	return result


func get_localization_match_cases(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "\t\tLocalizedID.%s: return %s\n" % [key.to_upper(), key.to_upper()]
	return result


func get_string_match_cases(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "\t\t%s: return LocalizedID.%s\n" % [key.to_upper(), key.to_upper()]
	return result


func get_localization_array(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "\t\t%s,\n" % key.to_upper()
	return result
