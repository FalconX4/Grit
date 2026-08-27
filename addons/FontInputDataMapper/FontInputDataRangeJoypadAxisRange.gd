@tool
extends FontInputDataRange
class_name FontInputDataRangeJoypadAxis

@export var value: JoypadMapEnum.AxisMap

func get_value_string() -> String:
	return FontInputDataRange.get_input_string_helper(JoypadMapEnum.AxisMap, value, "JoypadMapEnum.AxisMap")

func is_button() -> bool: return false
func is_axis() -> bool: return true
