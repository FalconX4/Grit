extends BaseMenu
class_name MainMenuScreen

@export var play_control: Control
@export var options_control: Control
@export var credit_control: Control
@export var back_button: Control
@export var buttons: Control

var last_focus: int = 0

func _init() -> void:
	type = MenuManager.MenuType.Main

func _ready() -> void:
	Helpers.node_disable(play_control)
	Helpers.node_disable(options_control)
	Helpers.node_disable(credit_control)
	super._ready()
	find_next_valid_focus().grab_focus()

func returned() -> void:
	super.returned()
	find_next_valid_focus().grab_focus()

func stack_open(menu_type: MenuManager.MenuType) -> void:
	super.stack_open(menu_type)

func play() -> void:
	stack_open(MenuManager.MenuType.WorldSelection)

func options() -> void:
	stack_open(MenuManager.MenuType.Options)

func credit() -> void:
	stack_open(MenuManager.MenuType.Credit)

func quit() -> void:
	get_tree().quit()
