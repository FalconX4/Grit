extends Control
class_name InventoryBar

@export var grid: InventoryBarSlotGrid

var selected_player: Player

func set_player(player: Player, doAnimations: bool):
	selected_player = player
	if selected_player == null:
		if doAnimations:
			hide_animation()
	else:
		var lenItems = len(selected_player.character.data.inventory_bar)
		for i in len(grid.slots):
			(grid.slots[i] as InventoryBarSlot).setup(i, selected_player.character.input_handler.input)
			if i >= lenItems:
				grid.slots[i].empty_item()
			else:
				grid.slots[i].set_item(selected_player.character.data.inventory_bar[i])

		if doAnimations:
			show_animation()


func show_animation():
	Helpers.node_enable(self)
	for slot in grid.slots:
		slot.show_animation()
func hide_animation():
	Helpers.node_disable(self)
	for slot in grid.slots:
		slot.hide_animation()
func show_slot_animation(index : int):
	Helpers.node_enable(self)
	grid.slots[index].show_animation()
func hide_slot_animation(index : int):
	grid.slots[index].hide_animation()
	var all_hiding_or_hidden = true
	for slot in grid.slots:
		if not (slot as InventoryBarSlot).is_hiding_or_hidden:
			all_hiding_or_hidden = false
			break
	if all_hiding_or_hidden:
		Helpers.node_disable(self)


func on_inventory_slot_clicked(item_slot: ItemSlot):
	if selected_player != null:
		selected_player.character.input_handler.set_item_selected(item_slot._item_data_count)


func _ready() -> void:
	if Helpers.is_main_scene(self):
		set_random_items()

	for slot in grid.slots:
		slot.click.connect(on_inventory_slot_clicked)

	show_animation()
	call_deferred("_after_ready")


func _after_ready() -> void:
	var old_size = size
	size = grid.size
	position -= (size - old_size) * 0.5


func set_random_items() -> void:
	for slot in grid.slots:
		slot.set_random_item()
