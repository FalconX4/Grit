extends ItemSlot
class_name InventoryBarSlot

@export var animation_player: AnimationPlayer
@export var input_label: InputLabel

var is_hiding_or_hidden: bool

func setup(index : int, character_input: CharacterInput = null):
	super.setup(index)
	var action = InputMapNames.GAME_INVENTORY_BAR_ + str((index + 1) % 10)
	var input_action = InputMapNames.get_action_input(action)
	input_label.set_input_action(input_action, character_input)

func show_animation():
	is_hiding_or_hidden = false
	Helpers.node_enable(self)
	animation_player.play("Show")

func hide_animation():
	is_hiding_or_hidden = true
	animation_player.play("Hide")
	animation_player.animation_finished.connect(on_hide_animation_finished)

func on_hide_animation_finished(_anim_name: StringName):
	animation_player.animation_finished.disconnect(on_hide_animation_finished)
	Helpers.node_disable(self)

func _ready() -> void:
	super._ready()
	if Helpers.is_main_scene(self):
		show_animation()
