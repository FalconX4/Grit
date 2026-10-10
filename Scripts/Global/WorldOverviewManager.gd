extends BaseSaveManager

const DATA_FILE_PATH: String = "user://worlds.sav"
const WORLD_DATA_FILE_PATH: String = "user://world/%s.world"
const ID_KEY = "id"
const WORLDS_KEY = "worlds"
const VERSION: String = "0.0.1"
const INVALID_WORLD = 0

var id: int = 1
var worlds_overview: Array[WorldOverviewData]

func _init() -> void:
	version = VERSION
	data_file_path = DATA_FILE_PATH
	super._init()
	id = get_setting(SECTION, ID_KEY, id)
	worlds_overview = get_setting(SECTION, WORLDS_KEY, worlds_overview)

func create(_name: String) -> WorldOverviewData:
	var world = WorldOverviewData.new(id, WORLD_DATA_FILE_PATH % _name, _name)
	worlds_overview.append(world)
	id += 1
	save()
	return world

func delete(data: WorldOverviewData) -> void:
	# TODO FEATURE SAVE: Delete auto saves too
	WorldManager.world = null
	WorldManager.world_overview = null
	if FileAccess.file_exists(data.path):
		DirAccess.remove_absolute(data.path)
	worlds_overview.erase(data)
	save()

func do_save() -> void:
	set_setting(SECTION, ID_KEY, id)
	set_setting(SECTION, WORLDS_KEY, worlds_overview)
	super.do_save()

func rename(data: WorldOverviewData, new_name: String) -> bool:
	for world in worlds_overview:
		if world != data and world.name == new_name:
			return false
	if FileAccess.file_exists(data.path):
		DirAccess.rename_absolute(data.path, WORLD_DATA_FILE_PATH % new_name)
	WorldManager.world = null
	data.name = new_name
	save()
	return true