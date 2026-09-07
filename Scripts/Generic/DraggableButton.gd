extends Button
class_name DraggableButton


@export var return_on_end_drag : bool


signal drag_started
signal drag_moved
signal drag_ended


const move_threshold = 10


var confirm_drag: Callable
var wants_drag = false
var dragging = false
var starting_mouse_position: Vector2
var starting_position: Vector2
var starting_global_position: Vector2
var last_mouse_position: Vector2

func _ready() -> void:
	button_down.connect(_on_button_button_down)
	button_up.connect(_on_button_button_up)


func _input(event: InputEvent) -> void:
	if wants_drag and event is InputEventMouseMotion:
		last_mouse_position = event.position
		var mouse_delta = last_mouse_position - starting_mouse_position
		if dragging:
			global_position = starting_global_position + mouse_delta
			drag_moved.emit(starting_mouse_position, last_mouse_position)
		elif mouse_delta.length_squared() > move_threshold * move_threshold:
			dragging = true
			top_level = true
			drag_started.emit()
			global_position = starting_global_position + mouse_delta
			drag_moved.emit(starting_mouse_position, last_mouse_position)


func _on_button_button_down() -> void:
	wants_drag = true
	starting_mouse_position = get_global_mouse_position()
	starting_position = position
	starting_global_position = global_position


func _on_button_button_up() -> void:
	wants_drag = false
	if dragging:
		if return_on_end_drag or (not confirm_drag.is_null() and not confirm_drag.call(last_mouse_position)):
			position = starting_position
		dragging = false
		top_level = false
		drag_ended.emit(starting_mouse_position, last_mouse_position)
