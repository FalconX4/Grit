extends Node

const DATA_FILE_PATH: String = "user://settings.cfg"

const SECTION: String = "general"
const VERSION_KEY: String = "version"
const VERSION: String = "0.0.1"

signal setting_version_changed	# Sent with old version as argument

var version: String

var _data: ConfigFile = ConfigFile.new()
var _data_loaded: bool = false

func get_setting(section: String, key: String, default_value: Variant = null) -> Variant:
	if _data_loaded:
		return _data.get_value(section, key, default_value)
	return default_value


func set_setting(section: String, key: String, value: Variant) -> void:
	if _data_loaded:
		_data.set_value(section, key, value)


func save_settings() -> void:
	if _data_loaded:
		_data.save(DATA_FILE_PATH)


func _init() -> void:
	if FileAccess.file_exists(DATA_FILE_PATH):
		_data_loaded = _data.load(DATA_FILE_PATH) == OK
		if not _data_loaded:
			push_error("Failed to load settings file: %s" % DATA_FILE_PATH)
		else:
			version = get_setting(SECTION, VERSION_KEY, VERSION)
			if version != VERSION:
				setting_version_changed.emit(version)
				_data.set_value(SECTION, VERSION_KEY, VERSION)
	else:
		_data = ConfigFile.new()
		_data.set_value(SECTION, VERSION_KEY, VERSION)
		_data.save(DATA_FILE_PATH)
		_data_loaded = true
		version = VERSION
