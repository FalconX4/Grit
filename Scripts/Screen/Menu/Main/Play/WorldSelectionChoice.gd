extends Control
class_name WorldSelectionChoice

@export var selected_visuals: Control
@export var name_label: Label
@export var rename_edit: LineEdit
@export var already_used_name_input: Label
@export var confirm_delete_dialog: LocalizedConfirmationDialog

signal on_selected(choice: WorldSelectionChoice)
signal on_deleted(choice: WorldSelectionChoice)

var data: WorldOverviewData
var is_selected: bool = false

func _ready() -> void:
	confirm_delete_dialog.confirmed.connect(_on_delete)
	Helpers.node_disable(rename_edit)
	Helpers.node_disable(already_used_name_input)
	Helpers.node_disable(selected_visuals)
	if Helpers.is_main_scene(self):
		var world = WorldOverviewData.new(0, "", "Test")
		setup(world)

func setup(world: WorldOverviewData) -> void:
	Helpers.node_disable(rename_edit)
	Helpers.node_disable(already_used_name_input)
	Helpers.node_enable(name_label)
	data = world
	name_label.text = data.name

func _process(_delta: float) -> void:
	Helpers.node_process_each_frame(selected_visuals, is_selected)

func _on_selected() -> void:
	is_selected = true
	on_selected.emit(self)

func _on_rename() -> void:
	if rename_edit.visible:
		_on_rename_done()
	else:
		rename_edit.text = name_label.text
		Helpers.node_enable(rename_edit)
		Helpers.node_disable(name_label)
		Helpers.node_disable(already_used_name_input)

func _on_rename_submitted(_new_text: String) -> void: _on_rename_done()
func _on_rename_done() -> void:
	if WorldOverviewManager.rename(data, rename_edit.text):
		name_label.text = data.name
		rename_finished()
	else:
		Helpers.node_enable(already_used_name_input)

func _on_rename_cancel() -> void: rename_finished()
func rename_finished() -> void:
	Helpers.node_disable(rename_edit)
	Helpers.node_disable(already_used_name_input)
	Helpers.node_enable(name_label)

func _on_try_delete() -> void:
	confirm_delete_dialog.localization_key_text_params[0] = data.name
	confirm_delete_dialog.popup_centered()

func _on_delete() -> void:
	WorldOverviewManager.delete(data)
	on_deleted.emit(self)
