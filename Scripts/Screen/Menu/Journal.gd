extends Control
class_name Journal

@onready var journal_page_1: JournalPage = $Container/PagePanel/JournalPage1
@onready var journal_page_2: JournalPage = $Container/PagePanel/JournalPage2
@onready var page_animation: AnimationPlayer = $Container/PageAnimation

var lastIndex = 0
var previous_key_pressed = false
var next_key_pressed = false


func _ready() -> void:
	update_page_1()
	update_page_2()

func _process(delta: float) -> void:
	var previousPressed = Input.is_key_pressed(KEY_A)
	var nextPressed = Input.is_key_pressed(KEY_D)
	if not previous_key_pressed and previousPressed:
		previous()
	if not next_key_pressed and nextPressed:
		next()
	previous_key_pressed = previousPressed
	next_key_pressed = nextPressed

func update_page_1():
	journal_page_1.set_data(DataManager.itemsData.items[lastIndex])

func update_page_2():
	journal_page_2.panel.visible = lastIndex + 1 < len(DataManager.itemsData.items)
	if journal_page_2.panel.visible:
		journal_page_2.set_data(DataManager.itemsData.items[lastIndex + 1])

func previous():
	if lastIndex - 2 >= 0 and not page_animation.is_playing():
		lastIndex -= 2
		page_animation.play("PreviousPage")

func next():
	var count = len(DataManager.itemsData.items)
	if lastIndex + 2 < count and not page_animation.is_playing():
		lastIndex += 2
		page_animation.play("NextPage")
