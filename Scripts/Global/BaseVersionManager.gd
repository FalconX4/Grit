extends Node
class_name BaseVersionManager

const VERSION_KEY: String = "version"

signal version_changed(version: String)

var version: String
var _old_version: String

func _ready() -> void:
	if _old_version != version:
		version_changed.emit(version)
	_old_version = version
