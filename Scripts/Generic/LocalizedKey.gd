extends Resource
class_name LocalizedKey

@export var raw_key: String
@export var params: Array[LocalizedKey]

var unprocessed_key: String
var processed_key: String
var processed_params: Array[String]

func _init(_raw_key: String = "") -> void:
	raw_key = _raw_key

func update_key() -> String: return _internal_update_key(0)
func _internal_update_key(depth: int = 0) -> String:
	if params.is_empty():
		if depth == 0:
			unprocessed_key = raw_key
		else:
			unprocessed_key = tr(raw_key)
		processed_key = unprocessed_key
	else:
		unprocessed_key = tr(raw_key)
		processed_params.clear()
		for param in params:
			if param:
				processed_params.append(param._internal_update_key(depth + 1))
			else:
				processed_params.append("%s")
		processed_key = unprocessed_key % processed_params
	return processed_key

func update_value_at(key: String, indexes: Array) -> String: return _internal_update_value_at(key, 0, indexes)
func _internal_update_value_at(key: String, index: int, indexes: Array) -> String:
	var checked_index = indexes[index]
	if index == len(indexes) - 1:
		if !params[checked_index]:
			params[checked_index] = LocalizedKey.new()
		params[checked_index].raw_key = key
		params[checked_index].unprocessed_key = key
		params[checked_index].processed_key = key
	else:
		params[checked_index]._internal_update_value_at(key, index + 1, indexes)
	processed_params[checked_index] = params[checked_index].processed_key
	processed_key = unprocessed_key % processed_params
	return processed_key

func update_localized_value_at(key: String, indexes: Array) -> String: return _internal_update_localized_value_at(key, 0, indexes)
func _internal_update_localized_value_at(key: String, index: int, indexes: Array) -> String:
	var checked_index = indexes[index]
	if index == len(indexes) - 1:
		params[checked_index].raw_key = key
		params[checked_index].unprocessed_key = tr(key)
		params[checked_index].processed_key = params[checked_index].unprocessed_key
	else:
		params[checked_index]._internal_update_localized_value_at(key, index + 1, indexes)
	processed_params[checked_index] = params[checked_index].processed_key
	processed_key = unprocessed_key % processed_params
	return processed_key

func update_localized_key_at(key: LocalizedKey, indexes: Array) -> String: return _internal_update_localized_key_at(key, 0, indexes)
func _internal_update_localized_key_at(key: LocalizedKey, index: int, indexes: Array) -> String:
	var checked_index = indexes[index]
	if index == len(indexes) - 1:
		key.update_key()
		params[checked_index] = key
	else:
		params[checked_index]._internal_update_localized_key_at(key, index + 1, indexes)
	processed_params[checked_index] = params[checked_index].processed_key
	processed_key = unprocessed_key % processed_params
	return processed_key
