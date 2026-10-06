extends HSlider
class_name HSliderFinal

signal final_value_changed(value: float)

var is_dragging: bool = false

func _init() -> void:
	value_changed.connect(_on_value_changed)
	drag_started.connect(_on_drag_started)
	drag_ended.connect(_on_drag_ended)

func _on_value_changed(new_value: float) -> void:
	if not is_dragging:
		final_value_changed.emit(new_value)

func _on_drag_started() -> void:
	is_dragging = true

func _on_drag_ended(has_value_changed: bool) -> void:
	is_dragging = false
	if has_value_changed:
		final_value_changed.emit(value)