extends Control
class_name JournalPage

@onready var panel: Panel = $Panel
@onready var image: TextureRect = $Panel/Image
@onready var title: Label = $Panel/Title
@onready var description: Label = $Panel/Description

func set_data(itemData: ItemData) -> void:
	image.texture = itemData.inventory_image
	title.text = itemData.name
	description.text = itemData.description
