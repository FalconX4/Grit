extends Node
class_name IconTimer

@export var container: Control
@export var icon: TextureRect
@export var label: Label
@export var timer: Timer
@export var input_action: InputMapNames.InputAction

signal timeout
var character_input: CharacterInput

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func _process(_delta: float) -> void:
	if container.visible:
		update_label()
		if not is_processing_input():
			stop()

func _input(event: InputEvent) -> void:
	var action_id = InputMapNames.get_action_string(input_action)
	action_id = character_input.get_device_action_id(action_id) if character_input != null else str(action_id)
	if event.is_action_pressed(action_id):
		start()
	elif event.is_action_released(action_id):
		stop()

func _on_timeout() -> void:
	container.visible = false
	timeout.emit()

func start() -> void:
	timer.start()
	container.visible = true
	update_label()

func stop() -> void:
	container.visible = false
	timer.stop()

func update_label() -> void:
	label.text = str(timer.time_left).pad_decimals(2)
