class_name CharacterData

var id: int
var name: String
var sprite: SpriteFrames
var inventory : Array[ItemDataCount]
var inventory_bar : Array[ItemDataCount]
var last_position: Vector2
var last_moved_direction : Vector2

func _init(_id: int = 0, _name: String = "", _sprite: SpriteFrames = null) -> void:
    id = _id
    name = _name
    sprite = _sprite