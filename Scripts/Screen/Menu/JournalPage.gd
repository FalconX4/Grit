extends Control
class_name JournalPage

@export var panel: Panel
@export var image: TextureRect
@export var title: Label
@export var description: Label
@export var default_item_data: ItemData
var current_item_data: ItemData

func _ready() -> void:
	if get_tree().current_scene == self:
		set_data(default_item_data)


func set_data(item_data: ItemData) -> void:
	current_item_data = item_data
	image.texture = item_data.journal_image
	title.text = item_data.name
	description.text = item_data.description
