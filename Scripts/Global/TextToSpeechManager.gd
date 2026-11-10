extends BaseVersionManager

const SECTION = "tts"
const ACTIVATED_KEY = "activated"
const VOICE_KEY = "voice"
const VERSION = "0.0.1"

var voices: PackedStringArray
var current_voice: int = 0
var is_active: bool

func _init() -> void:
	if not SettingManager.has_setting(SECTION, ACTIVATED_KEY):
		if DisplayServer.accessibility_screen_reader_active():
			update_language()
		else:
			is_active = false
	else:
		is_active = SettingManager.get_setting(SECTION, ACTIVATED_KEY, is_active)
	current_voice = SettingManager.get_setting(SECTION, VOICE_KEY, current_voice)
	if is_active:
		Localization.language_changed.connect(language_changed)

func set_activation(activate: bool) -> void:
	is_active = activate
	SettingManager.set_setting(SECTION, ACTIVATED_KEY, is_active)
	if is_active:
		language_changed()

func language_changed() -> void:
	update_language()
	test_voice()

func update_language() -> void:
	if Localization.current_language == "fro":
		voices = DisplayServer.tts_get_voices_for_language("fr")
	else:
		voices = DisplayServer.tts_get_voices_for_language(Localization.current_language)
	current_voice = 0
	SettingManager.set_setting(SECTION, VOICE_KEY, current_voice)

func change_voice(voice: int) -> void:
	current_voice = voice
	if current_voice < 0:
		current_voice = len(voices) - 1
	if current_voice >= len(voices):
		current_voice = len(voices) -1
	test_voice()
	SettingManager.set_setting(SECTION, VOICE_KEY, current_voice)

func test_voice() -> void:
	DisplayServer.tts_speak(tr(LocalizationMapNames.MENU_OPTIONS_GENERIC_TEXT_TO_SPEECH_VOICE_TEST), voices[current_voice])

func speak(text: String) -> void:
	DisplayServer.tts_speak(tr(text), voices[current_voice])
