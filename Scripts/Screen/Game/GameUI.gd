extends Control

@export var inventory_bar: InventoryBar
@export var inventory: InventoryWindow
@export var storage: StorageWindow
var selected_player: Player

func set_character_without_animation(path: NodePath):
	#selected_player = get_node(path) as Character
	inventory_bar.set_player(selected_player, false)

func _ready() -> void:
	storage.grid.columns = 6
	storage.set_enable(false)
	inventory.set_enable(false)
	if Helpers.is_main_scene(self):
		selected_player = CharacterManager.players[0]
		storage.set_random_items()
		inventory.set_random_items()
		inventory_bar.set_random_items()

func _process(_delta: float) -> void:
	if selected_player != inventory_bar.selected_player:
		inventory_bar.set_player(selected_player, true)
	if selected_player != inventory.selected_player:
		inventory.set_character(selected_player)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		return
	
	var is_my_event = true if not selected_player else selected_player.character.input_handler.is_my_event(event)
	if not is_my_event:
		return
		
	if Helpers.is_main_scene(self):
		var interacKey = selected_player.character.input_handler.input.get_device_action_id(InputMapNames.GAME_INTERACT) if selected_player else str(InputMapNames.GAME_INTERACT)
		if event.is_action_pressed(interacKey):
			storage.set_enable(!storage.visible)
			storage.set_random_items()
	var inventoryKey = selected_player.character.input_handler.input.get_device_action_id(InputMapNames.GAME_INVENTORY) if selected_player else str(InputMapNames.GAME_INVENTORY)
	if event.is_action_pressed(inventoryKey):
		inventory.set_enable(!inventory.visible)
