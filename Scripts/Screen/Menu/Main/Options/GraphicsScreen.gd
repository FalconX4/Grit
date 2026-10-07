extends Node
class_name GraphicsScreen

@export var screen_id_control: Control
@export var screen_id_dropdown: OptionButton
@export var screen_resolution_dropdown: OptionButton
@export var window_mode_dropdown: OptionButton
@export var screen_shake_checkbox: CheckBox


func _ready() -> void:
	var screen_count = GraphicsManager.get_screen_count()
	if screen_count > 1:
		screen_id_control.visible = true
		screen_id_dropdown.clear()
		for i in range(screen_count):
			screen_id_dropdown.add_item("Screen " + str(i), i)
			if GraphicsManager.screen_data.screen == i:
				screen_id_dropdown.selected = i
		screen_id_dropdown.item_selected.connect(_on_screen_id_changed)
	else:
		screen_id_control.visible = false

	var screen_resolution = GraphicsManager.get_screen_resolution()
	screen_resolution_dropdown.clear()
	for i in len(GraphicsManager.screen_resolutions):
		if GraphicsManager.screen_resolutions[i].resolution.x <= screen_resolution.x and GraphicsManager.screen_resolutions[i].resolution.y <= screen_resolution.y:
			screen_resolution_dropdown.add_item(GraphicsManager.screen_resolutions[i].label)
			if GraphicsManager.screen_resolutions[i].resolution == screen_resolution:
				screen_resolution_dropdown.selected = i
		else:
			break
	screen_resolution_dropdown.item_selected.connect(_on_screen_resolution_changed)
	
	window_mode_dropdown.clear()
	for i in len(GraphicsManager.window_mode_options):
		window_mode_dropdown.add_item(GraphicsManager.window_mode_options[i].name)
		if GraphicsManager.screen_data.mode == GraphicsManager.window_mode_options[i].mode and GraphicsManager.screen_data.borderless == GraphicsManager.window_mode_options[i].borderless:
			window_mode_dropdown.selected = i
	window_mode_dropdown.item_selected.connect(_on_window_mode_changed)
	
	screen_shake_checkbox.set_pressed_no_signal(GraphicsManager.screen_data.shake)
	screen_shake_checkbox.toggled.connect(_on_screen_shake_toggled)


func _on_screen_id_changed(index: int) -> void: GraphicsManager.set_window_id(index)
func _on_screen_resolution_changed(index: int) -> void: GraphicsManager.set_window_resolution(index)
func _on_window_mode_changed(index: int) -> void: GraphicsManager.set_window_mode(index)
func _on_screen_shake_toggled(pressed: bool) -> void: GraphicsManager.set_screen_shake(pressed)
