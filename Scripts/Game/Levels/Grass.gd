extends Node
class_name Grass

@export var starting_age = 0
@export var age_max = 10
@export var age_speed = 1
@export var sprite_2d: Sprite2D
@export var texture_size_start = 0
@export var texture_size_growing_speed = 3.6

var age = 0
var size = 0
var size_start = 0
var size_max = 0
var noise_texture: NoiseTexture2D
var noise: FastNoiseLite
var start_color: Color
var end_color: Color
var texture_size = 0

func _ready() -> void:
	size_start = texture_size_start + age_max * texture_size_growing_speed
	size_max = size_start
	size = size_max
	noise_texture = sprite_2d.texture as NoiseTexture2D
	noise = noise_texture.noise as FastNoiseLite
	noise.seed = randi()
	
	age = starting_age
	start_color = noise_texture.color_ramp.get_color(0)
	end_color = noise_texture.color_ramp.get_color(1)
	age_grass()


func _process(delta: float) -> void:
	if age >= age_max and size >= size_max:
		return

	age = min(age + age_speed * delta, age_max)
	size = min(size + texture_size_growing_speed * delta, size_max)
	age_grass()


func age_grass() -> void:
	var grewOf = size - size_start
	var newSize = (int)(texture_size_start + age * texture_size_growing_speed + grewOf)
	if newSize % 2 == 0:
		texture_size = newSize
	noise.offset = -Vector3((int)((grewOf) / 2), (int)((grewOf) / 2), 0)
	noise_texture.width = texture_size
	noise_texture.height = texture_size

	var startColor = start_color
	var endColor = end_color
	startColor.a = min(age / age_max * start_color.a, start_color.a)
	endColor.a = min(age / age_max * end_color.a, end_color.a)
	noise_texture.color_ramp.set_color(0, startColor)
	noise_texture.color_ramp.set_color(1, endColor)


func grow(sizeToGrow: float) -> void:
	size_max = size_max + sizeToGrow

func instant_grow(sizeToGrow: float) -> void:
	size_max = size_max + sizeToGrow
	size = size_max
	age_grass()
