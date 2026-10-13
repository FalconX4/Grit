extends BaseMenu
class_name OptionsScreen

func _init() -> void:
	type = MenuManager.MenuType.Options

func open() -> void:
	super.open()
	find_next_valid_focus().grab_focus()
