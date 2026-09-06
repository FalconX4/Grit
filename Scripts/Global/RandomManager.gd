extends Node

var random_seed: int = 0
var random_generator: RandomNumberGenerator = RandomNumberGenerator.new()

func _init() -> void:
	random_seed = 0 # randi()
	random_generator.seed = random_seed

func get_array(array: Array) -> Variant:
	return array[get_i(len(array))]

func get_i(max_range: int) -> int:
	return random_generator.randi_range(0, max_range - 1)

func get_f(max_range: float) -> float:
	return random_generator.randf_range(0.0, max_range - 0.0001)

func get_i_range(min_range: int, max_range: int) -> int:
	return random_generator.randi_range(min_range, max_range)

func get_f_range(min_range: float, max_range: float) -> float:
	return random_generator.randf_range(min_range, max_range)
