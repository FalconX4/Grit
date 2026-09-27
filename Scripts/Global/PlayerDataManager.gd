extends BaseSaveManager

const DATA_FILE_PATH: String = "user://player.sav"
const VERSION: String = "0.0.1"

func _init() -> void:
	version = VERSION
	data_file_path = DATA_FILE_PATH
	super._init()
