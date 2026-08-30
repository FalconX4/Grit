@tool
extends FontInputDataRange
class_name FontInputDataRangeJoypadButton

@export var button: JoypadMapEnum.ButtonMap

func get_value_string() -> String:
	return FontInputDataRange.get_input_string_helper(JoypadMapEnum.ButtonMap, button, "JoypadMapEnum.ButtonMap")
