extends Area2D
class_name InteractibleArea

@export var input_label: InputLabel

signal on_area_entered(body: CharacterBody)
signal interacted(character_input: CharacterInput)
signal on_area_exited(body: CharacterBody)

func _ready() -> void:
	input_label.action_pressed.connect(_interact)

func _interact(character_input: CharacterInput) -> void:
	interacted.emit(character_input)

func _on_enter_area(body: Node2D) -> void:
	var character = body as CharacterBody
	input_label.set_character_input(character.input_handler.input)
	Helpers.node_enable(input_label)
	on_area_entered.emit(character)

func _on_exit_area(body: Node2D) -> void:
	Helpers.node_disable(input_label)
	var character = body as CharacterBody
	on_area_exited.emit(character)
