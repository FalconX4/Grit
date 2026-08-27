class_name DeviceIdMapNames

enum DeviceId
{
	INVALID = -1,
	KEYBOARD = 0,
	MOUSE = 1,
	XBOX = 2,
	PLAYSTATION = 3,
	SWITCH = 4,
}

static func joypad_name_to_device_id(name: String) -> DeviceId:
	if name.contains("XInput"):
		return DeviceId.XBOX
	elif name.contains("playstation") or name.contains("dualsense") or name.contains("dualshock") or name.contains("sony") or name.contains("ps4") or name.contains("ps5"):
		return DeviceId.PLAYSTATION
	elif name.contains("switch") or name.contains("nintendo") or name.contains("joy-con") or name.contains("joycon") or name.contains("pro controller"):
		return DeviceId.SWITCH
	return DeviceId.INVALID
