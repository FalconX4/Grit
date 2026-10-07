@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_tool_menu_item("Build Scene", _on_button_pressed)

func _exit_tree():
	remove_tool_menu_item("Build Scene")

func _on_button_pressed() -> void:
	var current_main_scene = ProjectSettings.get_setting("application/run/main_scene")
	var loaded_scene = get_editor_interface().get_edited_scene_root().scene_file_path
	ProjectSettings.set_setting("application/run/main_scene", loaded_scene)
	ProjectSettings.save()
	var godot_path = OS.get_executable_path()
	var project_path = ProjectSettings.globalize_path("res://")
	var preset_name = "Windows Desktop"
	var output_path = "../Build/Grit.exe"
	if OS.execute(godot_path, ["--headless", "--path", project_path, "--export-release", preset_name, output_path]) != -1:
		OS.execute(output_path, [])
	ProjectSettings.set_setting("application/run/main_scene", current_main_scene)
	ProjectSettings.save()