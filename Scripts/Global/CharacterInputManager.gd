extends Node

var player_input_handlers: Array[CharacterInputHandler]
var _last_input_handler: CharacterInputHandler

func _init() -> void:
	player_input_handlers.append(CharacterInputHandler.new(PlayerInput.new()))
	if GameSessionData.player_count_on_this_computer > 1:
		for joypad in InputManager._joypads:
			var input = PlayerInput.new()
			input.set_device_id(joypad.device_id)
			player_input_handlers.append(CharacterInputHandler.new(input))

func _input(event: InputEvent) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		player_input_handlers[0].input.was_using_controller = player_input_handlers[0].input.using_controller
		player_input_handlers[0].input.using_controller = event is InputEventJoypadButton or event is InputEventJoypadMotion
		if player_input_handlers[0].input.using_controller:
			player_input_handlers[0].input.set_device_id(event.device)
	if event is InputEventKey or event is InputEventMouseButton:
		for input_handler in player_input_handlers:
			if not input_handler.input.using_controller:
				_last_input_handler = input_handler
				break
	elif event is InputEventJoypadButton or event is InputEventJoypadMotion:
		for input_handler in player_input_handlers:
				if event.device == (input_handler.input as PlayerInput).joypad.device_id:
					_last_input_handler = input_handler
					break
