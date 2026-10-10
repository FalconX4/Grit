class_name WorldOverviewData

var id: int
var path: String
var name: String
var profiles: Array[int]

func _init(_id: int = 0, _path: String = "", _name: String = "") -> void:
	id = _id
	path = _path
	name = _name
