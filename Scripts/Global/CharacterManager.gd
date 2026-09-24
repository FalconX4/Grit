extends Node

var players: Array[Player]
var _last_inputted_player: Player
func _init() -> void:
	if GameSessionData.player_count_on_this_computer > 1:
		for joypad in InputManager._joypads:
			var player = Player.new()
			(player.character.input_handler.input as PlayerInput).set_device_id(joypad.device_id)
			players.append(player)
	else:
		players.append(Player.new())

func _input(event: InputEvent) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		players[0].character.input_handler.input.was_using_controller = players[0].character.input_handler.input.using_controller
		players[0].character.input_handler.input.using_controller = event is InputEventJoypadButton or event is InputEventJoypadMotion
		if players[0].character.input_handler.input.using_controller:
			players[0].character.input_handler.input.set_device_id(event.device)
	if event is InputEventKey or event is InputEventMouseButton:
		for player in players:
			if not player.character.input_handler.input.using_controller:
				_last_inputted_player = player
				break
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		for player in players:
				if event.device == (player.character.input_handler.input as PlayerInput).joypad.device_id:
					_last_inputted_player = player
					break
