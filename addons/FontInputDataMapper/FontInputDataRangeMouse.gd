@tool
extends FontInputDataRange
class_name  FontInputDataRangeMouse

@export var value: MouseMapEnum.ButtonMap

func get_value_string() -> String:
	return FontInputDataRange.get_input_string_helper(MouseMapEnum.ButtonMap, value, "MouseMapEnum.ButtonMap")
