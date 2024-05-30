extends AnimationPlayer

@onready var interaction_tile: SoilTile = $"../../SoilTile/InteractionTile"
var already_played = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not already_played and not is_playing():
		if not interaction_tile.is_empty:
			already_played = true
			play()
