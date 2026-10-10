extends BaseSaveManager

const PLAYER_ID_KEY = "player_id"
const CHARACTER_ID_KEY = "character_id"
const WORLD_KEY = "world"
const VERSION: String = "0.0.1"

var player_id = 1
var character_id = 1
var world_overview: WorldOverviewData
var world: WorldData
var loaded_from_overview: bool

func _init() -> void:
	version = VERSION

func _load_from_overview(_world_overview: WorldOverviewData) -> WorldData:
	loaded_from_overview = true
	world_overview = _world_overview
	_load(world_overview.path)
	player_id = get_setting(SECTION, PLAYER_ID_KEY, player_id)
	character_id = get_setting(SECTION, CHARACTER_ID_KEY, character_id)
	world = get_setting(SECTION, WORLD_KEY, world)
	if not world:
		world = WorldData.new(world_overview.id, world_overview.name)
		save()
	if world.name != world_overview.name:
		world.name = world_overview.name
		save()
	check_version()
	return world

func do_save() -> void:
	if loaded_from_overview:
		# TODO FEATURE SAVE: Param for autosave and save to auto save
		set_setting(SECTION, PLAYER_ID_KEY, player_id)
		set_setting(SECTION, CHARACTER_ID_KEY, character_id)
		set_setting(SECTION, WORLD_KEY, world)
		super.do_save()
	else:
		# TODO FEATURE SAVE: Save other people game
		Debugger.log("Not implemented. Saving another person world into this computer")

func player_entered(player_data: PlayerData, character_data: CharacterData, profile_id: int) -> void:
	if player_data.id == 0:
		player_data.id = player_id
		player_id += 1
		player_data.original_character_id = character_id
		player_data.last_character_id = character_id
		character_data.id = character_id
		character_id += 1
		if not world_overview.profiles.find(profile_id):
			world_overview.profiles.append(profile_id)
