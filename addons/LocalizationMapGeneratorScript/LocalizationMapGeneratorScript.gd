@tool
extends EditorPlugin

const script_path: String = "res://Scripts/Helper/LocalizationMapNames.gd"
const generated_script_template: String = "class_name LocalizationMapNames
# Auto generated class made by LocalizationMapGeneratorScript

%s

static func get_all_actions() -> Array[StringName]:
	return [
%s
]
"

func _enter_tree() -> void:
	add_tool_menu_item("Generate Localization Map", _on_button_pressed)

func _exit_tree():
	remove_tool_menu_item("Generate Localization Map")

func _on_button_pressed() -> void:
	print("Beginning localization map script generation")
	var keys = localization_keys()
	var generated_script = generated_script_template % [
		get_localization_constants(keys),
		get_localization_array(keys)]
	var file = FileAccess.open(script_path, FileAccess.WRITE)
	file.store_string(generated_script)
	EditorInterface.get_resource_filesystem().update_file(script_path)
	print("Finished generating input map script at: %s" % script_path)

func localization_keys() -> PackedStringArray:
	var files: PackedStringArray = []
	var keys: PackedStringArray = []
	for localization in TranslationServer.get_translations():
		var remove_count = len(".") + len(localization.locale) + len(".translation")
		var file = localization.resource_path.erase(len(localization.resource_path) - remove_count, remove_count) + ".csv"
		
		if not file in files:
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

func get_localization_constants(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "const %s: StringName = &\"%s\"\n" % [key.to_upper(), key]
	return result


func get_localization_array(keys: PackedStringArray) -> String:
	var result = ""
	for key in keys:
		result += "\t\t%s,\n" % key.to_upper()
	return result
