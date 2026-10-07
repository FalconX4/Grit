@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_tool_menu_item("Delete User Data", _on_button_pressed)

func _exit_tree():
	remove_tool_menu_item("Delete User Data")

func _on_button_pressed() -> void:
	if DirAccess.dir_exists_absolute("user://"):
		delete_recursive("user://")

func delete_recursive(path: String) -> void:
	var dirs = DirAccess.get_directories_at(path)
	var files = DirAccess.get_files_at(path)
	for dir in dirs:
		delete_recursive(path + dir + "/")
		DirAccess.remove_absolute(path + dir)
	for file in files:
		DirAccess.remove_absolute(path + file)
