@tool
extends EditorPlugin

const script_path: String = "res://Scripts/Helper/InputMapNames.gd"
const generated_script_template: String = "class_name InputMapNames
# Auto generated class by InputMapGeneratorScript
	
enum InputAction {
%s
}

%s

static func get_action_string(action: InputAction) -> StringName:
	match action:
%s
		_:
			push_error(\"Unknown InputAction enum value: %%d\" %% action)
			return &\"\"

static func get_all_actions() -> Array[StringName]:
	return [
%s
	]
"

func _enter_tree() -> void:
	add_tool_menu_item("Generate Input Map", _on_button_pressed)

func _exit_tree():
	remove_tool_menu_item("Generate Input Map")

func _on_button_pressed() -> void:
	print("Beginning input map script generation")

	InputMap.load_from_project_settings()
	var actions = InputMap.get_actions()
	var generated_script = generated_script_template % [
		get_input_action_enum(actions),
		get_input_action_constants(actions),
		get_input_action_match_cases(actions),
		get_input_action_array(actions)]
	var file = FileAccess.open(script_path, FileAccess.WRITE)
	file.store_string(generated_script)
	EditorInterface.get_resource_filesystem().update_file(script_path)
	print("Finished generating input map script at: %s" % script_path)

func get_input_action_enum(actions: Array[StringName]) -> String:
	var result = ""
	for action in actions:
		if not action.contains("/") and not action.contains("."):
			result += "\t%s,\n" % action.to_upper()
	return result

func get_input_action_constants(actions: Array[StringName]) -> String:
	var result = ""
	for action in actions:
		if not action.contains("/") and not action.contains("."):
			result += "const %s: StringName = &\"%s\"\n" % [action.to_upper(), action]
	return result

func get_input_action_match_cases(actions: Array[StringName]) -> String:
	var result = ""
	for action in actions:
		if not action.contains("/") and not action.contains("."):
			result += "\t\tInputAction.%s: return %s\n" % [action.to_upper(), action.to_upper()]
	return result

func get_input_action_array(actions: Array[StringName]) -> String:
	var result = ""
	for action in actions:
		if not action.contains("/") and not action.contains("."):
			result += "\t\t%s,\n" % action.to_upper()
	return result
