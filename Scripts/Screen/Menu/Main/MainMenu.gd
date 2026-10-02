extends Control

func play() -> void:
	Debugger.log("Play")

func options() -> void:
	Debugger.log("Options")

func credit() -> void:
	Debugger.log("Credit")

func quit() -> void:
	get_tree().quit()
