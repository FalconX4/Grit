extends Control

@export var play_control: Control
@export var options_control: Control
@export var credit_control: Control
@export var back_button: Control
@export var buttons: Control

func _ready() -> void:
	back()

func play() -> void:
	open_window(play_control)

func options() -> void:
	open_window(options_control)

func credit() -> void:
	open_window(credit_control)

func quit() -> void:
	get_tree().quit()

func back() -> void:
	Helpers.node_disable(play_control)
	Helpers.node_disable(options_control)
	Helpers.node_disable(credit_control)
	Helpers.node_disable(back_button)
	Helpers.node_enable(buttons)

func open_window(control: Control) -> void:
	Helpers.node_enable(control)
	Helpers.node_enable(back_button)
	Helpers.node_disable(buttons)
