extends Control
class_name ItemSlotSelected

@export var cursor_scene: PackedScene
@export var frame: NinePatchRect
@export var cursor_container: HBoxContainer
var character_input_handlers: Dictionary[CharacterInputHandler, TextureRect]

func is_shown() -> bool:
	return frame.visible

func add_character_input(new_input_handler: CharacterInputHandler) -> void:
	for handle in character_input_handlers:
		if handle == new_input_handler:
			return
	frame.visible = true
	if GameSessionData.player_count_on_this_computer > 1:
		var cursor = Pool.take(cursor_scene, cursor_container) as TextureRect
		character_input_handlers[new_input_handler] = cursor
		if new_input_handler.small_icon_texture != null:
			character_input_handlers[new_input_handler].texture = new_input_handler.small_icon_texture
		character_input_handlers[new_input_handler].visible = true
		cursor_container.visible = true
	else:
		character_input_handlers[new_input_handler] = null

func remove_character_input(new_input_handler: CharacterInputHandler) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		frame.visible = false
		character_input_handlers.erase(new_input_handler)
	else:
		for handle in character_input_handlers:
			if handle == new_input_handler:
				Pool.release(character_input_handlers[new_input_handler])
				character_input_handlers[new_input_handler].visible = false
				character_input_handlers.erase(new_input_handler)
				if len(character_input_handlers) == 0:
					frame.visible = false
					cursor_container.visible = false
				break
