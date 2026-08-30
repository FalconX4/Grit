@tool
extends FontInputDataRange
class_name FontInputDataRangeJoypadAxis

@export var axis: JoypadMapEnum.AxisExtendedMap

func get_value_string() -> String:
	return FontInputDataRange.get_input_string_helper(JoypadMapEnum.AxisExtendedMap, axis, "JoypadMapEnum.AxisExtendedMap")

func is_button() -> bool: return false
func is_axis() -> bool: return true
