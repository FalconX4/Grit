extends Control
class_name ItemSlotSelected

@export var cursors: Array[TextureRect]
@export var frame: NinePatchRect
var character_inputs: Array[CharacterInput]

func add() -> void:
	frame.visible = true

func remove() -> void:
	frame.visible = false

func add_character_input(new_input: CharacterInput) -> void:
	cursors[len(character_inputs)].visible = true
	character_inputs.append(new_input)

func remove_character_input(new_input: CharacterInput) -> void:
	character_inputs.erase(new_input)
