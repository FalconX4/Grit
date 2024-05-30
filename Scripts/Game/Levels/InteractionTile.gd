extends StaticBody2D
class_name InteractionTile

var interacted = false

func is_interactable(_character: Character) -> bool:
	return true

func interact(character: Character):
	if is_interactable(character):
		interacted = true

func _process(_delta: float) -> void:
	interacted = false
