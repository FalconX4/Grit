extends InteractionTile
class_name SoilTile

@export var animated_sprite_2d: AnimatedSprite2D
@export var plowedNode: Node
@export var age = 0
var is_empty = true
var item : ItemSeedData = null

func is_interactable(characterBody: CharacterBody) -> bool:
	var selected_index = characterBody.input_handler.inventory_bar_selected_index
	return selected_index >= 0 \
		and len(characterBody.inventory_bar) > selected_index \
		and characterBody.inventory_bar[selected_index].has_item() \
		and characterBody.inventory_bar[selected_index].item.item_type() == ItemData.ItemType.SEED


func interact(characterBody: CharacterBody) -> void:
	super.interact(characterBody)
	if interacted:
		var selected_index = characterBody.input_handler.inventory_bar_selected_index
		plowedNode.visible = true
		item = characterBody.inventory_bar[selected_index].item as ItemSeedData
		characterBody.inventory_bar[selected_index].empty()
		animated_sprite_2d.visible = true
		is_empty = false


func _process(_delta: float) -> void:
	if item == null:
		animated_sprite_2d.visible = false
		is_empty = true
		return

	for i in len(item.age_each_step):
		if age >= item.age_each_step[i]:
			animated_sprite_2d.sprite_frames = item.frames_each_step[i]
			animated_sprite_2d.offset = item.pivot_each_step[i]
