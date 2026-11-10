extends Node
class_name AccessibilityScreen

@export var text_to_speech: CheckBox
@export var text_to_speech_voice: SpinBox
@export var colorblind: OptionButton
@export var one_handed: CheckBox # Like set WASD to arrays

enum ColorBlind
{
	Deactivated,
	Protanopia, # red-blind, red from Green: red = dark gray
	Deuteranopia, # green-blind, red from green: green = beige
	Tritanopia, # blue-blind, blue from yellow
	Achromatopsia # see no color
}

func _ready() -> void:
	text_to_speech.button_pressed = TextToSpeechManager.is_active
	text_to_speech.toggled.connect(_on_text_to_speech_changed)
	text_to_speech_voice.value = TextToSpeechManager.current_voice
	text_to_speech_voice.value_changed.connect(_on_text_to_speech_voice_changed)

func _on_text_to_speech_changed(toggled_on: bool) -> void:
	TextToSpeechManager.set_activation(toggled_on)
	Helpers.node_process(text_to_speech_voice, toggled_on)

func _on_text_to_speech_voice_changed(value: float) -> void:
	TextToSpeechManager.change_voice((int)(value))
	text_to_speech_voice.set_value_no_signal(TextToSpeechManager.current_voice)
