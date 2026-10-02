class_name Player

var character: Character
var data: PlayerData
var game_ui: GameUI

func _init() -> void:
	data = PlayerData.new()
	character = Character.new()
	character.input_handler = CharacterInputHandler.new(PlayerInput.new())
