extends Control
class_name WorldCreationScreen

@export var name_edit: LineEdit

signal on_created(data: WorldOverviewData)

func create() -> void:
	on_created.emit(WorldOverviewManager.create(name_edit.text))