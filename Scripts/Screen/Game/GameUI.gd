extends Control

@export var inventory: InventoryBar
@export var storage: Storage
var selected_character: Character

func set_character_without_animation(path: NodePath):
	selected_character = get_node(path) as Character
	inventory.set_character(selected_character, false)

func _ready() -> void:
	if Helpers.is_main_scene(self):
		storage.set_random_items()

func _process(_delta: float) -> void:
	if selected_character != inventory.selected_character:
		inventory.set_character(selected_character, true)


func _input(event: InputEvent) -> void:
	if selected_character == null:
		if event.is_action_pressed(InputMapNames.GAME_INTERACT):
			storage.visible = !storage.visible
