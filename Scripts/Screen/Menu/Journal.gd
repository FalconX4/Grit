extends Control
class_name Journal

@export var journal_page_1: JournalPage
@export var journal_page_2: JournalPage
@export var page_animation: AnimationPlayer

var lastIndex = 0
var character_input: CharacterInput

func _ready() -> void:
	update_page_1()
	update_page_2()


func _process(_delta: float) -> void:
	var previous_action_id = character_input.get_device_action_id(InputMapNames.GAME_MOVE_LEFT) if character_input != null else str(InputMapNames.GAME_MOVE_LEFT)
	var next_action_id = character_input.get_device_action_id(InputMapNames.GAME_MOVE_RIGHT) if character_input != null else str(InputMapNames.GAME_MOVE_RIGHT)
	if InputManager.is_action_just_pressed(previous_action_id):
		previous()
	if InputManager.is_action_just_pressed(next_action_id):
		next()


func open(new_character_input: CharacterInput) -> void:
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	character_input = new_character_input


func update_page_1():
	journal_page_1.set_data(DataManager.items_data.items[lastIndex])


func update_page_2():
	journal_page_2.panel.visible = lastIndex + 1 < len(DataManager.items_data.items)
	if journal_page_2.panel.visible:
		journal_page_2.set_data(DataManager.items_data.items[lastIndex + 1])


func previous():
	if lastIndex - 2 >= 0 and not page_animation.is_playing():
		lastIndex -= 2
		page_animation.play("PreviousPage")


func next():
	var count = len(DataManager.items_data.items)
	if lastIndex + 2 < count and not page_animation.is_playing():
		lastIndex += 2
		page_animation.play("NextPage")
