extends WorldItemBody
class_name StorageBody

@export var sprite: Sprite2D
@export var interactible_area: InteractibleArea

signal open(player: Player)

func create_world_item_data() -> WorldItemData: return StorageData.new(item_data, position, rotation)

func _ready() -> void:
	super._ready()
	interactible_area.interacted.connect(_open)

func _open(character_input: CharacterInput) -> void:
	var player = PlayerManager.find_player_from_input(character_input)
	if player.game_ui:
		open.emit(player)
