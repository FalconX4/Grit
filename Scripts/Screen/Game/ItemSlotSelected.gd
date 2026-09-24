extends Control
class_name ItemSlotSelected

@export var cursor_scene: PackedScene
@export var frame: NinePatchRect
@export var cursor_container: HBoxContainer
var players: Dictionary[Player, TextureRect]

func is_shown() -> bool:
	return frame.visible

func add_player(new_player: Player) -> void:
	for handle in players:
		if handle == new_player:
			return
	frame.visible = true
	if GameSessionData.player_count_on_this_computer > 1:
		var cursor = Pool.take(cursor_scene, cursor_container) as TextureRect
		players[new_player] = cursor
		if new_player.small_icon_texture != null:
			players[new_player].texture = new_player.small_icon_texture
		players[new_player].visible = true
		cursor_container.visible = true
	else:
		players[new_player] = null

func remove_player(new_player: Player) -> void:
	if GameSessionData.player_count_on_this_computer == 1:
		frame.visible = false
		players.erase(new_player)
	else:
		for handle in players:
			if handle == new_player:
				Pool.release(players[new_player])
				players[new_player].visible = false
				players.erase(new_player)
				if len(players) == 0:
					frame.visible = false
					cursor_container.visible = false
				break
