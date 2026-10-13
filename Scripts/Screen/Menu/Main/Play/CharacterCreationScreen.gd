extends BaseMenu
class_name CharacterCreationScreen

@export var name_edit: LineEdit
@export var character: AnimatedSprite2D

signal on_create(data: CharacterData)

func _init() -> void:
	type = MenuManager.MenuType.CharacterCreation

func _create() -> void:
	var data = CharacterData.new(0, name_edit.text, character.sprite_frames)
	on_create.emit(data)
