extends BaseSaveManager

const WORLD_KEY = "world"
const VERSION: String = "0.0.1"

var world_overview: WorldOverviewData
var world: WorldData

func _init() -> void:
	version = VERSION

func _load_from_overview(_world_overview: WorldOverviewData) -> int:
	world_overview = _world_overview
	_load(world_overview.path)
	world = get_setting(SECTION, WORLD_KEY, world)
	if not world:
		world = WorldData.new(world_overview.id, world_overview.name)
	return world.id

func save() -> void:
	set_setting(SECTION, WORLD_KEY, world)
	super.save()
