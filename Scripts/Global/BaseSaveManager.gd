extends BaseVersionManager
class_name BaseSaveManager

const SECTION: String = "general"

var queue_save: bool
var data_file_path: String

var _data: ConfigFile = ConfigFile.new()
var _data_loaded: bool = false

func get_setting(section: String, key: String, default_value: Variant = null) -> Variant:
	if _data_loaded:
		return _data.get_value(section, key, default_value)
	return default_value

func set_setting(section: String, key: String, value: Variant) -> void:
	if _data_loaded:
		_data.set_value(section, key, value)

func save() -> void:
	queue_save = true

func _init() -> void: _load(data_file_path)
func _load(path: String) -> void:
	data_file_path = path
	if FileAccess.file_exists(data_file_path):
		_data_loaded = _data.load(data_file_path) == OK
		if not _data_loaded:
			push_error("Failed to load settings file: %s" % data_file_path)
		else:
			_old_version = get_setting(SECTION, VERSION_KEY, version)
			_data.set_value(SECTION, VERSION_KEY, version)
			save()
	else:
		_data = ConfigFile.new()
		_data.set_value(SECTION, VERSION_KEY, version)
		_data_loaded = true

func _ready() -> void:
	super._ready()
	_try_save()

func _process(_delta: float) -> void:
	_try_save()

func _try_save() -> void:
	if queue_save and _data_loaded:
		queue_save = false
		do_save()

func do_save() -> void:
	_data.save(data_file_path)
