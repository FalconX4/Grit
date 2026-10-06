extends Control
class_name SliderShownValue

@export var slider: HSlider
@export var spin_box: SpinBox

func _ready() -> void:
	slider.value_changed.connect(_on_slider_value_changed)
	_on_slider_value_changed(slider.value)

func _on_slider_value_changed(value: float) -> void:
	if spin_box:
		spin_box.value = value

func _on_spin_box_value_changed(value: float) -> void:
	slider.value = value