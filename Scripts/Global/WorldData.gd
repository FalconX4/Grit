class_name WorldData

var id: int
var name: String
var players: Array[PlayerData]
var characters: Array[CharacterData]
var items: Array[WorldItemData]

func _init(_id: int, _name: String) -> void:
	id = _id
	name = _name

func add_player(player: Player) -> void:
	players.append(player.data)
	add_character(player.character.data)

func add_character(character: CharacterData) -> void:
	characters.append(character)

func create_items() -> void:
	for item in items:
		var new_item = item.create_world_item()
		new_item.create(item)

func add_item(item: WorldItem) -> void:
	items.append(item)

func remove_item(item: WorldItem) -> void:
	items.erase(item.data)
