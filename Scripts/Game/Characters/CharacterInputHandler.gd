class_name CharacterInputHandler

var input: CharacterInput

var small_icon_texture: Texture2D
var move: Vector2
var interact: bool
var item_selected: ItemDataCount

func _init(_input: CharacterInput) -> void:
	input = _input

func _process(_delta: float) -> void:
	move = input.get_vector(InputMapNames.GAME_MOVE_LEFT, InputMapNames.GAME_MOVE_RIGHT, InputMapNames.GAME_MOVE_UP, InputMapNames.GAME_MOVE_DOWN)
	interact = input.is_action_just_pressed(InputMapNames.GAME_INTERACT)


func is_my_event(event: InputEvent) -> bool:
	if input.using_controller and (event is InputEventJoypadButton or event is InputEventJoypadMotion):
		return input.joypad.device_id == event.device
	else:
		return !input.using_controller

func set_item_selected(item: ItemDataCount) -> void:
	item_selected = item
