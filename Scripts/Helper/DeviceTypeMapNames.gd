class_name DeviceTypeMapNames

enum DeviceType
{
	INVALID = -1,
	KEYBOARD = 0,
	MOUSE = 1,
	XBOX = 2,
	PLAYSTATION = 3,
	SWITCH = 4,
}

static func joypad_name_to_device_type(name: String) -> DeviceType:
	if name.contains("XInput"):
		return DeviceType.XBOX
	elif name.contains("playstation") or name.contains("dualsense") or name.contains("dualshock") or name.contains("sony") or name.contains("ps4") or name.contains("ps5"):
		return DeviceType.PLAYSTATION
	elif name.contains("switch") or name.contains("nintendo") or name.contains("joy-con") or name.contains("joycon") or name.contains("pro controller"):
		return DeviceType.SWITCH
	return DeviceType.INVALID

static func is_device_type_joypad(device_type: DeviceType) -> bool:
	return device_type != DeviceType.INVALID and device_type != DeviceType.KEYBOARD and device_type != DeviceType.MOUSE

static func is_event_joypad(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion

static func is_event_as_device(event: InputEvent, device_type: DeviceType) -> bool:
	var wants_joypad = is_device_type_joypad(device_type)
	return ((device_type == DeviceType.KEYBOARD or device_type == DeviceType.MOUSE) && (event is InputEventKey or event is InputEventMouseButton)) or (wants_joypad and DeviceTypeMapNames.is_event_joypad(event))
