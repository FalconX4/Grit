extends Control
class_name ItemSlotSelected

@export var cursor_scene: PackedScene
@export var frame: NinePatchRect
@export var cursor_container: HBoxContainer
var characters: Dictionary[Character, TextureRect]

func is_shown() -> bool:
	return frame.visible

func add_character(new_character: Character) -> void:
	for handle in characters:
		if handle == new_character:
			return
	frame.visible = true
	if GameSessionData.player_count_on_this_computer > 1:
		var cursor = Pool.take(cursor_scene, cursor_container) as TextureRect
		characters[new_character] = cursor
		if new_character.small_icon_texture != null:
			characters[new_character].texture = new_character.small_icon_texture
		characters[new_character].visible = true
		cursor_container.visible = true
	else:
		characters[new_character] = null

func remove_character(new_character: Character) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		frame.visible = false
		characters.erase(new_character)
	else:
		for handle in characters:
			if handle == new_character:
				Pool.release(characters[new_character])
				characters[new_character].visible = false
				characters.erase(new_character)
				if len(characters) == 0:
					frame.visible = false
					cursor_container.visible = false
				break
