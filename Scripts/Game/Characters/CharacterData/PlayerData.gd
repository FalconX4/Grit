class_name PlayerData

var id: int
var profile_id: int
var original_character_id: int
var last_character_id: int
var is_playing: bool
var mission_unlocked: Array[int]
var mission_done: Array[int]
var achievement_done: Array[int]
var journal_unlocked: Array[int]

func _init(_id: int = 0, _profile_id: int = 0, _character_id: int = 0) -> void:
    id = 0
    profile_id = _profile_id
    original_character_id = _character_id
    last_character_id = _character_id