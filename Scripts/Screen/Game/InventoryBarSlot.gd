extends ItemSlot
class_name InventoryBarSlot

@export var animation_player: AnimationPlayer
@export var input_label: InputLabel

func setup(index : int, character_input: CharacterInput = null):
	super.setup(index)
	var action = InputMapNames.GAME_INVENTORY_BAR_ + str((index + 1) % 10)
	var input_action = InputMapNames.get_action_input(action)
	input_label.set_input_action(input_action, character_input)


func show_animation():
	animation_player.play("Show")


func hide_animation():
	animation_player.play("Hide")

func _ready() -> void:
	super._ready()
	if Helpers.is_main_scene(self):
		show_animation()
