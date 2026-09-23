extends StaticBody2D
class_name InteractionTile

var interacted = false

func is_interactable(_characterBody: CharacterBody) -> bool:
	return true


func interact(_characterBody: CharacterBody):
	if is_interactable(_characterBody):
		interacted = true


func _process(_delta: float) -> void:
	interacted = false
