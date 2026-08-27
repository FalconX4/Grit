class_name FontInputDataMapNames
# Auto generated class by FontInputDataMapNamesGeneratorScript

enum MappingEnum
{
	BUTTONS,
	AXIS
}

const mapping: Dictionary[DeviceIdMapNames.DeviceId, Array] = {
	DeviceIdMapNames.DeviceId.MOUSE: [ FontInputDataMouseMapNames.mapping_button, FontInputDataMouseMapNames.mapping_axis ],
	DeviceIdMapNames.DeviceId.XBOX: [ FontInputDataXboxMapNames.mapping_button, FontInputDataXboxMapNames.mapping_axis ],

}

static func get_button(device_id: DeviceIdMapNames.DeviceId, button_id: int) -> String:
	return mapping[device_id][MappingEnum.BUTTONS][button_id]

static func get_axis(device_id: DeviceIdMapNames.DeviceId, axis_id: int) -> String:
	return mapping[device_id][MappingEnum.AXIS][axis_id]

static func input_to_text(event: InputEvent, device_id_enum: DeviceIdMapNames.DeviceId) -> String:
	if event is InputEventJoypadButton:
		return FontInputDataMapNames.get_button(device_id_enum, event.button_index)
	elif event is InputEventJoypadMotion:
		return FontInputDataMapNames.get_axis(device_id_enum, event.axis)
	elif event is InputEventMouseButton:
		return FontInputDataMapNames.get_button(device_id_enum, event.button_index)
	return str(event.button_index)
