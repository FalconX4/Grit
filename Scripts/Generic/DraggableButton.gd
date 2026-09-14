extends Button
class_name DraggableButton


@export var return_on_end_drag : bool
@export var move_on_top: bool


signal drag_started(is_mouse_right_drag: bool)
signal drag_moved(start_mouse_position: Vector2, last_mouse_position: Vector2)
signal drag_ended(starting_mouse_position: Vector2, last_mouse_position: Vector2)


const move_threshold = 10

var can_drag: Callable
var can_stop_drag: Callable
var cancel_drag: Callable
var wants_drag = false
var dragging = false
var starting_mouse_position: Vector2
var starting_position: Vector2
var starting_global_position: Vector2
var last_mouse_position: Vector2
var is_mouse_right_drag: bool

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not wants_drag and event.is_pressed():
			_on_button_down()
		elif wants_drag and event.is_released():
			_on_button_up()


func _input(event: InputEvent) -> void:
	if wants_drag and event is InputEventMouseMotion:
		last_mouse_position = event.position
		var mouse_delta = last_mouse_position - starting_mouse_position
		if dragging:
			global_position = starting_global_position + mouse_delta
			drag_moved.emit(starting_mouse_position, last_mouse_position)
		elif mouse_delta.length_squared() > move_threshold * move_threshold:
			start_dragging(starting_global_position + mouse_delta, is_mouse_right_drag)


func _on_button_down() -> void:
	if not can_drag.is_null() and not can_drag.call():
		return
	is_mouse_right_drag = Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT)
	prepare_dragging(true)


func _on_button_up() -> void:
	if can_stop_drag.is_null() or can_stop_drag.call():
		stop_dragging(starting_mouse_position, last_mouse_position)


func prepare_dragging(_wants_drag: bool) -> void:
	wants_drag = _wants_drag
	starting_position = position
	starting_global_position = global_position
	starting_mouse_position = get_global_mouse_position()
	var rect = get_global_rect()
	if not rect.has_point(starting_mouse_position):
		starting_mouse_position = rect.position + rect.size * 0.5


func start_dragging(_global_position: Vector2, _is_mouse_right_drag: bool) -> void:
	is_mouse_right_drag = _is_mouse_right_drag
	dragging = true
	if move_on_top:
		top_level = true
	drag_started.emit(_is_mouse_right_drag)
	global_position = _global_position


func stop_dragging(_starting_mouse_position: Vector2, _last_mouse_position: Vector2) -> void:
	wants_drag = false
	if dragging:
		if return_on_end_drag or (not cancel_drag.is_null() and cancel_drag.call(_last_mouse_position)):
			position = starting_position
		dragging = false
		if move_on_top:
			top_level = false
		drag_ended.emit(_starting_mouse_position, _last_mouse_position)
