extends Node

class JoypadData:
	var device_id: int
	var connected: bool
	var name: String
	var device_type: DeviceTypeMapNames.DeviceType
	var buttons: Dictionary[String, String]

const _default_joypad_buttons: Array[String] = [
	InputMapNames.GAME_MOVE_UP,
	InputMapNames.GAME_MOVE_DOWN,
	InputMapNames.GAME_MOVE_LEFT,
	InputMapNames.GAME_MOVE_RIGHT,
	InputMapNames.GAME_INTERACT,
	InputMapNames.GAME_INVENTORY_BAR_0,
	InputMapNames.GAME_INVENTORY_BAR_1,
	InputMapNames.GAME_INVENTORY_BAR_2,
	InputMapNames.GAME_INVENTORY_BAR_3,
	InputMapNames.GAME_INVENTORY_BAR_4,
	InputMapNames.GAME_INVENTORY_BAR_5,
	InputMapNames.GAME_INVENTORY_BAR_6,
	InputMapNames.GAME_INVENTORY_BAR_7,
	InputMapNames.GAME_INVENTORY_BAR_8,
	InputMapNames.GAME_INVENTORY_BAR_9,
]

const SECTION = "Inputs"
const KEYBOARD_KEY = "Keyboard"
const JOYPAD_KEY = "Joypad"
const VERSION = "0.0.1"

signal input_version_changed
signal last_input_joypad_changed

var keyboard_buttons: Dictionary[String, String]
var _joypads: Array[JoypadData] = []
var _last_input_joypad: bool = false
var _last_device_type: DeviceTypeMapNames.DeviceType

func _input(event: InputEvent) -> void:
	var old_input_joypad = _last_input_joypad
	if event is InputEventMouseMotion:
		return

	_last_input_joypad = event is InputEventJoypadButton or event is InputEventJoypadMotion
	
	if _last_input_joypad:
		_last_device_type = DeviceTypeMapNames.DeviceType.INVALID
		for joypad in _joypads:
			if joypad.device_id == event.device:
				_last_device_type = joypad.device_type
	else:
		_last_device_type = DeviceTypeMapNames.DeviceType.KEYBOARD if event is InputEventKey else DeviceTypeMapNames.DeviceType.MOUSE

	if old_input_joypad != _last_input_joypad:
		last_input_joypad_changed.emit(_last_input_joypad)

func _init() -> void:
	Input.joy_connection_changed.connect(_on_joy_connection_changed)


func _ready() -> void:
	keyboard_buttons = SettingManager.get_setting(SECTION, KEYBOARD_KEY, keyboard_buttons)
	set_keyboard()

	_joypads = SettingManager.get_setting(SECTION, JOYPAD_KEY, _joypads)
	if _joypads == null or _joypads.is_empty():
		for joypad in Input.get_connected_joypads():
			add_new_joy(joypad)
	
	var version = SettingManager.get_setting(SECTION, SettingManager.VERSION_KEY, VERSION)
	if version != VERSION:
		input_version_changed.emit(version)
		SettingManager.set_value(SECTION, SettingManager.VERSION_KEY, VERSION)


func _on_joy_connection_changed(device: int, connected: bool) -> void:
	if connected:
		print("Joypad connected: %d" % device)
		var found = false
		for joypad in _joypads:
			if joypad.device_id == device:
				joypad.connected = true
				found = true
		if not found:
			add_new_joy(device)
	else:
		print("Joypad disconnected: %d" % device)
		_joypads = _joypads.filter(func(j: JoypadData) -> bool: return j.device_id != device)


func add_new_joy(device: int) -> void:
	var joypad = JoypadData.new()
	joypad.device_id = device
	joypad.connected = true
	joypad.name = Input.get_joy_name(device)
	joypad.device_type = DeviceTypeMapNames.joypad_name_to_device_type(joypad.name)
	print("New joypad connected: " + joypad.name)
	_joypads.append(joypad)

	var joypadNumber = "Joypad" + str(len(_joypads)) + "_"
	if not InputMap.has_action(joypadNumber + _default_joypad_buttons[0]):
		for button in _default_joypad_buttons:
			var first = true
			var action_name = joypadNumber + button
			var events = InputMap.action_get_events(button)
			for event in events:
				if event is InputEventJoypadButton or event is InputEventJoypadMotion:
					if first:
						first = false
						InputMap.add_action(action_name)
					InputMap.action_add_event(action_name, event)
					joypad.buttons[button] = action_name


func set_keyboard() -> void:
	for button in _default_joypad_buttons:
		var action_name = "Keyboard_" + button
		InputMap.add_action(action_name)
		var events = InputMap.action_get_events(button)
		for event in events:
			if event is not InputEventJoypadButton and event is not InputEventJoypadMotion:
				InputMap.action_add_event(action_name, event)
				keyboard_buttons[button] = action_name


func save_input() -> void:
	SettingManager.set_setting(SECTION, KEYBOARD_KEY, keyboard_buttons)
	SettingManager.set_setting(SECTION, JOYPAD_KEY, _joypads)


func get_joypad(device: int) -> JoypadData:
	for joypad in _joypads:
		if joypad.device_id == device:
			return joypad
	return null

func is_action_just_pressed(action_id: String) -> bool:
	if Input.is_action_just_pressed(action_id): return true
	elif keyboard_buttons.has(action_id) and Input.is_action_just_pressed(keyboard_buttons[action_id]): return true
	else:
		for joypad in _joypads:
			if joypad.buttons.has(action_id) and Input.is_action_just_pressed(joypad.buttons[action_id]):
				return true
	return false

func is_action_just_released(action_id: String) -> bool:
	if Input.is_action_just_released(action_id): return true
	elif Input.is_action_just_released(keyboard_buttons[action_id]): return true
	else:
		for joypad in _joypads:
			if Input.is_action_just_released(joypad.buttons[action_id]):
				return true
	return false

func get_action_text(action_id: String, device_type: DeviceTypeMapNames.DeviceType) -> String:
	for event in InputMap.action_get_events(action_id):
		if DeviceTypeMapNames.is_event_as_device(event, device_type):
			return FontInputDataMapNames.input_to_text(event, device_type)
	return action_id
