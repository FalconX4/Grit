extends BaseSaveManager

const DATA_FILE_PATH: String = "user://profiles.sav"
const ID_KEY = "id"
const LAST_PROFILE_KEY = "last_profile"
const PROFILES_KEY = "profiles"
const VERSION: String = "0.0.1"

var id: int = 1
var profiles: Array[ProfileData]
var current_profile_index: int = 0

var current_profile: ProfileData

func _init() -> void:
	version = VERSION
	data_file_path = DATA_FILE_PATH
	super._init()
	id = get_setting(SECTION, ID_KEY, id)
	profiles = get_setting(SECTION, PROFILES_KEY, profiles)
	current_profile_index = get_setting(SECTION, LAST_PROFILE_KEY, current_profile_index)
	if current_profile_index == 0:
		current_profile = create("Default")
	else:
		current_profile = find_by_id(current_profile_index)

func create(_name: String) -> ProfileData:
	var profile = ProfileData.new(id, _name)
	id += 1
	profiles.append(profile)
	save()
	return profile

func delete(profile: ProfileData) -> void:
	profiles.erase(profile)
	save()

func do_save() -> void:
	set_setting(SECTION, ID_KEY, id)
	set_setting(SECTION, LAST_PROFILE_KEY, current_profile_index)
	set_setting(SECTION, PROFILES_KEY, profiles)
	super.do_save()

func find_by_id(_id: int) -> ProfileData:
	for profile in profiles:
		if profile.id == _id:
			return profile
	return null

func switch_profile(_name: String) -> ProfileData:
	for profile in profiles:
		if profile.name == _name:
			current_profile = profile
			if current_profile_index == profile.id:
				current_profile_index = profile.id
				save()
			return profile
	return null

