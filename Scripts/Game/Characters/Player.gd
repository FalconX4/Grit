class_name Player

var character: Character
var player_data: PlayerData

func _init() -> void:
	player_data = PlayerData.new()
	character = Character.new()
	character.input_handler = CharacterInputHandler.new(PlayerInput.new())
