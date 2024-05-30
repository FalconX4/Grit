extends Resource
class_name ItemData

enum Type { NONE, SEED, TOOL, FOOD, OTHER }

func type() -> Type: return Type.NONE
@export var name : String
@export var description : String
@export var description_from : String
@export var description_effect : String
@export var inventory_image : Texture2D
@export var inventory_bar_image : Texture2D
