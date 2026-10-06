extends BaseVersionManager

enum AudioBus
{
	MASTER,
	MUSIC,
	SFX
}

class VolumeData:
	var master_volume: float = 1.0
	var music_volume: float = 1.0
	var sfx_volume: float = 1.0

const SECTION = "audio"
const VOLUME_KEY = "volume"
const VERSION = "0.0.1"

var volume_data: VolumeData = VolumeData.new()

var _volume_buses: Dictionary = {
	AudioBus.MASTER: "Master",
	AudioBus.MUSIC: "Music",
	AudioBus.SFX: "SFX"
}

var _volume_bus_indices: Dictionary = {
	AudioBus.MASTER: AudioServer.get_bus_index(_volume_buses[AudioBus.MASTER]),
	AudioBus.MUSIC: AudioServer.get_bus_index(_volume_buses[AudioBus.MUSIC]),
	AudioBus.SFX: AudioServer.get_bus_index(_volume_buses[AudioBus.SFX])
}

func _init() -> void:
	volume_data = SettingManager.get_setting(SECTION, VOLUME_KEY, volume_data)
	AudioServer.set_bus_volume_db(_volume_bus_indices[AudioBus.MASTER], linear_to_db(volume_data.master_volume))
	AudioServer.set_bus_volume_db(_volume_bus_indices[AudioBus.MUSIC], linear_to_db(volume_data.music_volume))
	AudioServer.set_bus_volume_db(_volume_bus_indices[AudioBus.SFX], linear_to_db(volume_data.sfx_volume))

	version = VERSION
	_old_version = SettingManager.get_setting(SECTION, SettingManager.VERSION_KEY, version)
	SettingManager.set_setting(SECTION, SettingManager.VERSION_KEY, version)

func set_volume(bus: AudioBus, volume: float) -> void:
	match bus:
		AudioBus.MASTER:
			volume_data.master_volume = volume
			AudioServer.set_bus_volume_db(_volume_bus_indices[AudioBus.MASTER], linear_to_db(volume_data.master_volume))
		AudioBus.MUSIC:
			volume_data.music_volume = volume
			AudioServer.set_bus_volume_db(_volume_bus_indices[AudioBus.MUSIC], linear_to_db(volume_data.music_volume))
		AudioBus.SFX:
			volume_data.sfx_volume = volume
			AudioServer.set_bus_volume_db(_volume_bus_indices[AudioBus.SFX], linear_to_db(volume_data.sfx_volume))
	SettingManager.set_setting(SECTION, VOLUME_KEY, volume_data)

func get_volume(bus: AudioBus) -> float:
	match bus:
		AudioBus.MASTER:
			return volume_data.master_volume
		AudioBus.MUSIC:
			return volume_data.music_volume
		AudioBus.SFX:
			return volume_data.sfx_volume
	return 0.0