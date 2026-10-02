extends BaseSaveManager

const DATA_FILE_PATH: String = "user://profiles.sav"
const ID_KEY = "id"
const PROFILES_KEY = "profiles"
const VERSION: String = "0.0.1"

var id: int = 1
var profiles: Array[ProfileData]
var profiles_dictionary: Dictionary[int, ProfileData]

func _init() -> void:
	version = VERSION
	data_file_path = DATA_FILE_PATH
	super._init()
	id = get_setting(SECTION, ID_KEY, id)
	profiles = get_setting(SECTION, PROFILES_KEY, profiles)
	for profile in profiles:
		profiles_dictionary[profile.id] = profile

func create(_name: String) -> ProfileData:
	var profile = ProfileData.new(id, _name)
	id += 1
	profiles.append(profile)
	profiles_dictionary[profile.id] = profile
	save()
	return profile

func delete(profile: ProfileData) -> void:
	profiles_dictionary.erase(profile.id)
	profiles.erase(profile)
	save()

func save() -> void:
	set_setting(SECTION, ID_KEY, id)
	set_setting(SECTION, PROFILES_KEY, profiles)
	super.save()


func find(_id: int) -> ProfileData:
	return profiles_dictionary[_id]
