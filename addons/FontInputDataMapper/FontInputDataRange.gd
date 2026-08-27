@tool
extends Resource
class_name FontInputDataRange

@export var character: String = "E000"
@export var range: String = "0 0 -6"

static func get_input_string_helper(input_enum, value, suffix) -> String:
	var keys = input_enum.keys()
	for key in input_enum:
		if input_enum[key] == value:
			return key if suffix == "" else "%s.%s" % [ suffix, key ]
	return ""

func get_value_string() -> String:
	return ""

func is_button() -> bool: return true
func is_axis() -> bool: return false
