extends Control
class_name BaseMenu

@export var control_to_open_on_stack_open: Control
@export var control_to_close_on_stack_open: Control

var type: MenuManager.MenuType

func _enter_tree() -> void:
	MenuManager.subscribe(self)

func _exit_tree() -> void:
	MenuManager.unsubscribe(self)

func _ready() -> void:
	if Helpers.is_main_scene(self):
		MenuManager.stack_open(type)

func _unhandled_input(event: InputEvent) -> void:
	if visible and event.is_action_pressed(InputMapNames.UI_CANCEL):
		MenuManager.back()
		get_viewport().set_input_as_handled()

func open() -> void:
	Helpers.node_enable(self)
	_on_stack_open(false)

func returned() -> void:
	_on_stack_open(false)

func close() -> void:
	Helpers.node_disable(self)

func back() -> void:
	MenuManager.back()

func close_all_stack_open(menu_type: MenuManager.MenuType) -> void:
	MenuManager.close_all_stack_open(menu_type)

func stack_close_open(menu_type: MenuManager.MenuType) -> void:
	MenuManager.stack_close_open(menu_type)

func stack_open(menu_type: MenuManager.MenuType) -> void:
	MenuManager.stack_open(menu_type)
	_on_stack_open(true)

func _on_stack_open(enable: bool) -> void:
	if control_to_open_on_stack_open:
		Helpers.node_process(control_to_open_on_stack_open, enable)
	if control_to_close_on_stack_open:
		Helpers.node_process(control_to_close_on_stack_open, !enable)
