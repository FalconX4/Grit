extends Resource
class_name ItemData

enum Type { NONE, SEED, TOOL, FOOD }

func type() -> Type: return Type.NONE
@export var name : String
@export var description : String
@export var inventory_image : Texture2D
@export var journal_image : Texture2D
