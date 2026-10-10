class_name WorldData

var id: int
var name: String
var players: Array[PlayerData]
var characters: Array[CharacterData]
var items: Array[WorldItemData]

func _init(_id: int = 0, _name: String = "") -> void:
	id = _id
	name = _name

func add_player(player: Player) -> void:
	players.append(player.data)
	add_character(player.character.data)

func add_character(character: CharacterData) -> void:
	characters.append(character)

func remove_player_data(player_data: PlayerData) -> void:
	characters.remove_at(find_character_data_index(player_data.original_character_id))
	players.erase(player_data)

func find_character_data(_id: int) -> CharacterData:
	var index = find_character_data_index(_id)
	return null if index == -1 else characters[index]

func find_character_data_index(_id: int) -> int:
	for i in len(characters):
		if characters[i].id == _id:
			return i
	return -1

func create_items() -> void:
	for item in items:
		var new_item = item.create_world_item()
		new_item.create(item)

func add_item(item: WorldItem) -> void:
	items.append(item)

func remove_item(item: WorldItem) -> void:
	items.erase(item.data)
