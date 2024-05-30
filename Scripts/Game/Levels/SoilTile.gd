extends InteractionTile
class_name SoilTile

@onready var animated_sprite_2d: AnimatedSprite2D = $"../AnimatedSprite2D"
@export var age = 0
var is_empty = true
var item : SeedData = null

func is_interactable(character: Character) -> bool:
	return character.selected_item_index >= 0 \
		and len(character.items) > character.selected_item_index \
		and character.items[character.selected_item_index] != null \
		and character.items[character.selected_item_index].type() == ItemData.Type.SEED

func interact(character: Character):
	super.interact(character)
	if interacted:
		item = character.items[character.selected_item_index] as SeedData
		character.items.remove_at(character.selected_item_index)
		animated_sprite_2d.visible = true
		animated_sprite_2d.play("default")
		is_empty = false

func _process(_delta: float) -> void:
	if item == null:
		animated_sprite_2d.visible = false
		is_empty = true
		return

	for i in len(item.age_each_step):
		if age >= item.age_each_step[i]:
			animated_sprite_2d.sprite_frames = item.frames_each_step[i]
