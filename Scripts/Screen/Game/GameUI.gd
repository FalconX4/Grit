extends Control

@export var inventory_bar: InventoryBar
@export var inventory: InventoryWindow
@export var storage: StorageWindow
var selected_character: Character

func set_character_without_animation(path: NodePath):
	#selected_character = get_node(path) as Character
	inventory_bar.set_character(selected_character, false)

func _ready() -> void:
	storage.grid.columns = 6
	storage.set_enable(false)
	inventory.set_enable(false)
	if Helpers.is_main_scene(self):
		selected_character = CharacterManager.players[0]
		storage.set_random_items()
		inventory.set_random_items()
		inventory_bar.set_random_items()

func _process(_delta: float) -> void:
	if selected_character != inventory_bar.selected_character:
		inventory_bar.set_character(selected_character, true)
	if selected_character != inventory.selected_character:
		inventory.set_character(selected_character)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	
	var is_my_event = true if not selected_character else selected_character.input_handler.is_my_event(event)
	if not is_my_event:
		return
		
	if Helpers.is_main_scene(self):
		var interacKey = selected_character.input_handler.input.get_device_action_id(InputMapNames.GAME_INTERACT) if selected_character else str(InputMapNames.GAME_INTERACT)
		if event.is_action_pressed(interacKey):
			storage.set_enable(!storage.visible)
			storage.set_random_items()
	var inventoryKey = selected_character.input_handler.input.get_device_action_id(InputMapNames.GAME_INVENTORY) if selected_character else str(InputMapNames.GAME_INVENTORY)
	if event.is_action_pressed(inventoryKey):
		inventory.set_enable(!inventory.visible)
