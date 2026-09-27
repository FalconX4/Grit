extends WorldItem
class_name Storage

func setup(_body: WorldItemBody, _data: WorldItemData) -> void:
	super.setup(_body, _data)
	body.open.connect(open)

func create(_data: WorldItemData) -> void:
	super.create(_data)
	body.open.connect(open)

func open(player: Player)-> void:
	player.game_ui.storage.grid.columns = data.item_data.columns
	player.game_ui.storage.grid.rows = data.item_data.rows
	player.game_ui.storage.set_enable(!player.game_ui.storage.visible)
	player.game_ui.storage.set_random_items()
