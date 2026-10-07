extends BaseVersionManager

class WindowModeOption:
	var name: String
	var mode: Window.Mode
	var borderless: bool
	func _init(_name: String, _mode: Window.Mode, _borderless: bool) -> void:
		self.name = _name
		self.mode = _mode
		self.borderless = _borderless

var window_mode_options: Array[WindowModeOption] = [WindowModeOption.new("Fullscreen", Window.MODE_FULLSCREEN, false),
												   WindowModeOption.new("Windowed", Window.MODE_WINDOWED, false),
												   WindowModeOption.new("Borderless", Window.MODE_WINDOWED, true)]

class ScreenResolutionOption:
	var label: String
	var resolution: Vector2i
	func _init(_label: String, _resolution: Vector2i) -> void:
		self.label = _label
		self.resolution = _resolution

var screen_resolutions: Array[ScreenResolutionOption] = [ScreenResolutionOption.new("640x480", Vector2i(640, 480)),
														ScreenResolutionOption.new("800x600", Vector2i(800, 600)),
														ScreenResolutionOption.new("1024x768", Vector2i(1024, 768)),
														ScreenResolutionOption.new("1152x864", Vector2i(1152, 864)),
														ScreenResolutionOption.new("1280x720", Vector2i(1280, 720)),
														ScreenResolutionOption.new("1280x800", Vector2i(1280, 800)),
														ScreenResolutionOption.new("1280x1024", Vector2i(1280, 1024)),
														ScreenResolutionOption.new("1360x768", Vector2i(1360, 768)),
														ScreenResolutionOption.new("1366x768", Vector2i(1366, 768)),
														ScreenResolutionOption.new("1440x900", Vector2i(1440, 900)),
														ScreenResolutionOption.new("1600x900", Vector2i(1600, 900)),
														ScreenResolutionOption.new("1680x1050", Vector2i(1680, 1050)),
														ScreenResolutionOption.new("1920x1080", Vector2i(1920, 1080)),
														ScreenResolutionOption.new("1920x1200", Vector2i(1920, 1200)),
														ScreenResolutionOption.new("2048x1080", Vector2i(2048, 1080)),
														ScreenResolutionOption.new("2560x1080", Vector2i(2560, 1080)),
														ScreenResolutionOption.new("2560x1440", Vector2i(2560, 1440)),
														ScreenResolutionOption.new("2560x1600", Vector2i(2560, 1600)),
														ScreenResolutionOption.new("3440x1440", Vector2i(3440, 1440)),
														ScreenResolutionOption.new("3840x1080", Vector2i(3840, 1080)),
														ScreenResolutionOption.new("3840x1600", Vector2i(3840, 1600)),
														ScreenResolutionOption.new("3840x2160", Vector2i(3840, 2160)),
														ScreenResolutionOption.new("5120x1440", Vector2i(5120, 1440)),
														ScreenResolutionOption.new("5120x2160", Vector2i(5120, 2160)),
														ScreenResolutionOption.new("5120x2880", Vector2i(5120, 2880)),
														ScreenResolutionOption.new("6016x3384", Vector2i(6016, 3384)),
														ScreenResolutionOption.new("7680x4320", Vector2i(7680, 4320))]


const SECTION = "graphics"
const SCREEN_KEY = "screen"
const VERSION = "0.0.1"

class ScreenData:
	var screen: int = DisplayServer.SCREEN_PRIMARY
	var resolution: Vector2i = DisplayServer.screen_get_size()
	var mode: Window.Mode = Window.MODE_FULLSCREEN
	var borderless: bool = false
	var shake: bool = true

var window: Window
var screen_data: ScreenData = ScreenData.new()

func _init() -> void:
	screen_data = SettingManager.get_setting(SECTION, SCREEN_KEY, screen_data)

	version = VERSION
	_old_version = SettingManager.get_setting(SECTION, SettingManager.VERSION_KEY, version)
	SettingManager.set_setting(SECTION, SettingManager.VERSION_KEY, version)

func _ready() -> void:
	window = get_window()
	window.current_screen = screen_data.screen
	window.size = screen_data.resolution
	window.mode = screen_data.mode
	window.borderless = screen_data.borderless
	center_window()

func center_window() -> void:
	var screen_size = DisplayServer.screen_get_size(window.current_screen)
	var window_size = window.size
	var new_position = Vector2((screen_size.x - window_size.x) / 2.0, (screen_size.y - window_size.y) / 2.0)
	window.position = new_position

func set_window_id(id: int) -> void:
	window.current_screen = id
	screen_data.screen = window.current_screen

func set_window_resolution(index: int) -> void:
	window.size = screen_resolutions[index].resolution
	screen_data.resolution = window.size
	center_window()

func set_window_mode(index: int) -> void:
	window.mode = window_mode_options[index].mode
	window.borderless = window_mode_options[index].borderless
	screen_data.mode = window.mode
	screen_data.borderless = window.borderless
	center_window()

func set_screen_shake(can_shake: bool) -> void:
	screen_data.shake = can_shake

func get_screen_resolution() -> Vector2i: return DisplayServer.screen_get_size(screen_data.screen)
func get_screen_count() -> int:	return DisplayServer.get_screen_count()

func save() -> void:
	SettingManager.set_setting(SECTION, SCREEN_KEY, screen_data)
	SettingManager.save()
