class_name FontInputDataMapNames
# Auto generated class by FontInputDataMapNamesGeneratorScript

enum MappingEnum
{
	BUTTONS,
	AXIS
}

const mapping: Dictionary[DeviceTypeMapNames.DeviceType, Array] = {
	DeviceTypeMapNames.DeviceType.MOUSE: [ FontInputDataMouseMapNames.mapping_button, FontInputDataMouseMapNames.mapping_axis ],
	DeviceTypeMapNames.DeviceType.PLAYSTATION: [ FontInputDataPS4MapNames.mapping_button, FontInputDataPS4MapNames.mapping_axis ],
	DeviceTypeMapNames.DeviceType.XBOX: [ FontInputDataXboxMapNames.mapping_button, FontInputDataXboxMapNames.mapping_axis ],

}

static func get_button(device_type: DeviceTypeMapNames.DeviceType, button_id: int) -> String:
	return mapping[device_type][MappingEnum.BUTTONS][button_id]

static func get_axis(device_type: DeviceTypeMapNames.DeviceType, axis_id: JoyAxis, value: float) -> String:
	var axis_extended = JoypadMapEnum.get_axis_extended(axis_id, value)
	return mapping[device_type][MappingEnum.AXIS][axis_extended]

static func input_to_text(event: InputEvent, device_type: DeviceTypeMapNames.DeviceType) -> String:
	if event is InputEventMouseButton:
		return get_button(device_type, event.button_index)
	elif event is InputEventJoypadButton:
		return get_button(device_type, event.button_index)
	elif event is InputEventJoypadMotion:
		return get_axis(device_type, event.axis, event.axis_value)
	elif event is InputEventKey:
		return get_keyboard_localized(event.physical_keycode if event.physical_keycode != 0 else event.keycode)
	return event.as_text()

static func get_keyboard_localized(keycode: int) -> String:
	if keycode == 0:
		return ""
	var os_keycode = OS.get_keycode_string(keycode)
	if os_keycode.is_empty():
		return ""
	var key: String = "KEY_%s" % os_keycode.strip_edges().replace(" ", "_").to_upper()
	var key_translated: String = TranslationServer.translate(key)
	if key_translated != key:
		return key_translated
	return os_keycode
