extends ItemData
class_name ItemSeedData

func type() -> Type: return Type.SEED
@export var frames_each_step : Array[SpriteFrames]
@export var pivot_each_step : Array[Vector2]
@export var age_each_step : Array[int]
@export var collision_each_step : Array[float]
@export var grass_area_each_step : Array[float]
@export var items_to_give_each_step : Array[ItemData]
