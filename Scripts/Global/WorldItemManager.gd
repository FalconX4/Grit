extends BaseVersionManager

const SECTION = "WorldItem"
const ITEMS_KEY = "Items"
const VERSION = "0.0.1"

var items: Array[WorldItemData]
var created_items: Array[WorldItem]

func _init() -> void:
	items = PlayerDataManager.get_setting(SECTION, ITEMS_KEY, items)
	version = VERSION
	_old_version = PlayerDataManager.get_setting(SECTION, SettingManager.VERSION_KEY, version)
	PlayerDataManager.set_setting(SECTION, SettingManager.VERSION_KEY, version)

func create_item() -> void:
	for item in items:
		var new_item = item.create_world_item()
		new_item.create(item)

func save() -> void:
	PlayerDataManager.set_setting(SECTION, ITEMS_KEY, items)
