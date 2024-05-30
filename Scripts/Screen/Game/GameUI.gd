extends Control


@onready var inventory: Inventory = $Inventory
var selected_character: Character


func set_character_without_animation(path: NodePath):
	selected_character = get_node(path) as Character
	inventory.set_character(selected_character, false)

func _process(_delta: float) -> void:
	if selected_character != inventory.selected_character:
		inventory.set_character(selected_character, true)
