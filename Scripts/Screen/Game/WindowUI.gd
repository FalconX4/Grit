extends Control
class_name WindowUI

@export var button: Button
@export var moved_control: Control

var start_global_position: Vector2

func _ready() -> void:
	call_deferred("_after_ready")

func _after_ready() -> void:
	if moved_control == null:
		Debugger.log_error_with_stack("WindowUI named", name, "attached to nothing")
		return

	start_global_position = moved_control.global_position
	global_position = start_global_position
	size = moved_control.size

func _on_button_drag_started() -> void:
	start_global_position = global_position

func _on_button_drag_moved(start_mouse_position: Vector2, last_mouse_position: Vector2) -> void:
	global_position = start_global_position + (last_mouse_position - start_mouse_position)
	if moved_control != null:
		moved_control.global_position = global_position

func _on_button_drag_ended(start_mouse_position: Vector2, last_mouse_position: Vector2) -> void:
	global_position = start_global_position + (last_mouse_position - start_mouse_position)
	if moved_control != null:
		moved_control.global_position = global_position
