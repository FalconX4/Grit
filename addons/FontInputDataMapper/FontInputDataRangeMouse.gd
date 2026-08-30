@tool
extends FontInputDataRange
class_name  FontInputDataRangeMouse

@export var button: MouseMapEnum.ButtonMap

func get_value_string() -> String:
	return FontInputDataRange.get_input_string_helper(MouseMapEnum.ButtonMap, button, "MouseMapEnum.ButtonMap")
