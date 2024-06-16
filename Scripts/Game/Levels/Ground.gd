extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	var noiseTexture = sprite_2d.texture as NoiseTexture2D
	var noise = noiseTexture.noise as FastNoiseLite
	noise.seed = randi()
