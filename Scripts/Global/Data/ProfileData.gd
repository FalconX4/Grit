class_name ProfileData

var id: int
var name: String
var settings_id: int
var last_world_id: int
var last_player_id: int
var achievements: Array[int]

func _init(_id: int = 0, _name: String = "") -> void:
	id = _id
	name = _name
