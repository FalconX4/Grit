extends Node

var players: Array[Character]
var _last_inputted_player: Character
func _init() -> void:
	if GameSessionData.player_count_on_this_computer > 1:
		for joypad in InputManager._joypads:
			var character = Character.new()
			var input = PlayerInput.new()
			input.set_device_id(joypad.device_id)
			character.input_handler = CharacterInputHandler.new(input)
			players.append(character)
	else:
		var character = Character.new()
		var input = PlayerInput.new()
		character.input_handler = CharacterInputHandler.new(input)
		players.append(character)

func _input(event: InputEvent) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		players[0].input_handler.input.was_using_controller = players[0].input_handler.input.using_controller
		players[0].input_handler.input.using_controller = event is InputEventJoypadButton or event is InputEventJoypadMotion
		if players[0].input_handler.input.using_controller:
			players[0].input_handler.input.set_device_id(event.device)
	if event is InputEventKey or event is InputEventMouseButton:
		for player in players:
			if not player.input_handler.input.using_controller:
				_last_inputted_player = player
				break
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		for player in players:
				if event.device == (player.input_handler.input as PlayerInput).joypad.device_id:
					_last_inputted_player = player
					break
