extends SliderShownValue
class_name VolumeSlider

@export var _volume_bus: AudioManager.AudioBus = AudioManager.AudioBus.MASTER

func _ready() -> void:
	slider.value = AudioManager.get_volume(_volume_bus) * 100
	super._ready()
	if slider is HSliderFinal:
		slider.final_value_changed.connect(_on_slider_value_changed)
	else:
		slider.value_changed.connect(_on_slider_value_changed)

func _on_slider_value_changed(value: float) -> void:
	super._on_slider_value_changed(value)
	AudioManager.set_volume(_volume_bus, value / 100.0)