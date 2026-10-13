extends BaseMenu
class_name WorldCreationScreen

@export var name_edit: LineEdit
@export var warning_text: LocalizedLabel

signal on_created(data: WorldOverviewData)

func _init() -> void:
	type = MenuManager.MenuType.WorldCreation

func _ready() -> void:
	Helpers.node_disable(warning_text)
	super._ready()
	visibility_changed.connect(_on_visible_changed)
	if Helpers.is_main_scene(self):
		name_edit.grab_focus()

func _on_visible_changed() -> void:
	if visible:
		name_edit.grab_focus()

func _delayed_ready() -> void:
	name_edit.grab_focus()

func _on_create() -> void:
	if name_edit.text.is_empty():
		Helpers.node_enable(warning_text)
		warning_text.text = LocalizationMapNames.GENERIC_CANNOT_BE_EMPTY
	elif WorldOverviewManager.check_name_already_exist(name_edit.text):
		Helpers.node_enable(warning_text)
		warning_text.text = LocalizationMapNames.MENU_WORLD_NAME_ALREADY_EXIST
	else:
		back()
		on_created.emit(WorldOverviewManager.create(name_edit.text))
