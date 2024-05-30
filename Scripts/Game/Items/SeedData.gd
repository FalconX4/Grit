extends ItemData
class_name SeedData

func type() -> Type: return Type.SEED
@export var frames_each_step : Array[SpriteFrames]
@export var age_each_step : Array[int]
@export var collision_each_step : Array[CircleShape2D]
@export var grass_area_each_step : Array[float]
@export var items_to_give_each_step : Array
