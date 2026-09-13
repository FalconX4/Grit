extends Control

@export var inventory_bar: InventoryBar
@export var inventory: InventoryWindow
@export var storage: StorageWindow
var selected_character: Character

func set_character_without_animation(path: NodePath):
	selected_character = get_node(path) as Character
	inventory_bar.set_character(selected_character, false)

func _ready() -> void:
	storage.set_enable(false)
	inventory.set_enable(false)
	if Helpers.is_main_scene(self):
		storage.set_random_items()
		inventory.set_random_items()
		inventory_bar.set_random_items()

func _process(_delta: float) -> void:
	if selected_character != inventory_bar.selected_character:
		inventory_bar.set_character(selected_character, true)
	if selected_character != inventory.selected_character:
		inventory.set_character(selected_character)

func _input(event: InputEvent) -> void:
	if selected_character == null:
		if event.is_action_pressed(InputMapNames.GAME_INTERACT):
			storage.set_enable(!storage.visible)
			storage.set_random_items()
		elif event.is_action_pressed(InputMapNames.GAME_INVENTORY):
			inventory.set_enable(!inventory.visible)
			inventory.set_random_items()
