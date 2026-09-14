@tool
extends MenuButton
class_name ItemSlotRightClickMenu

@export var function_node: Node
@export var menus: Dictionary[LocalizationMapNames.LocalizedID, String]

func _init() -> void:
	action_mode = BaseButton.ACTION_MODE_BUTTON_RELEASE
	button_mask = MOUSE_BUTTON_MASK_RIGHT
	mouse_filter = Control.MOUSE_FILTER_PASS
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)

func _ready() -> void:
	get_popup().clear()
	for menu in menus:
		get_popup().add_item(LocalizationMapNames.enum_to_string(menu))
		get_popup().index_pressed.connect(_index_pressed)

func _index_pressed(index: int) -> void:
	function_node.call(menus[index])

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index != MOUSE_BUTTON_RIGHT:
		return
