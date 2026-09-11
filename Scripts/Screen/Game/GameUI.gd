extends Control

@export var inventory_bar: InventoryBar
@export var storage: StorageWindow
var selected_character: Character

func set_character_without_animation(path: NodePath):
	selected_character = get_node(path) as Character
	inventory_bar.set_character(selected_character, false)

func _ready() -> void:
	storage.set_process_input(false)
	if Helpers.is_main_scene(self):
		storage.set_random_items()
		inventory_bar.set_random_items()

func _process(_delta: float) -> void:
	if selected_character != inventory_bar.selected_character:
		inventory_bar.set_character(selected_character, true)

func _input(event: InputEvent) -> void:
	if selected_character == null:
		if event.is_action_pressed(InputMapNames.GAME_INTERACT):
			storage.set_enable(!storage.visible)
