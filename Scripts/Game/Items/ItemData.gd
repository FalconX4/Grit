extends Resource
class_name ItemData

enum ItemType { NONE, SEED, TOOL, FOOD }

func item_type() -> ItemType: return ItemType.NONE
@export var name : String
@export var description : String
@export var inventory_image : Texture2D
@export var journal_image : Texture2D
