extends CharacterBody2D
class_name CharacterBody

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var input_label: InputLabel = $InputLabel
@onready var interact_trigger: ShapeCast2D = $DirectionNode/InteractTrigger
@onready var direction_node: Node2D = $DirectionNode
@export var age_sprite_frames: Dictionary
@export var age = 0.0
@export var speed = 300.0

var input_handler: CharacterInputHandler
var data: CharacterData

func show_interact_button(show_it: bool): input_label.visible = show_it


func update_input_buttons(): update_input_button(input_label, InputMapNames.InputAction.GAME_INTERACT)
func update_input_button(label: InputLabel, input_action: InputMapNames.InputAction):
	if label != null:
		label.set_input_action(input_action, input_handler.character_input)


func _ready() -> void:
	if Helpers.is_main_scene(self):
		input_handler = CharacterManager.players[0].input_handler
		data = CharacterManager.players[0].data
	update_input_buttons()


func _process(_delta: float) -> void:
	if not animation_player:
		return

	input_handler._process(_delta)
	if input_handler.character_input.was_using_controller != input_handler.character_input.using_controller:
		update_input_buttons()

	if interact_trigger.is_colliding():
		for i in interact_trigger.get_collision_count():
			var collider = interact_trigger.get_collider(i)
			if collider is InteractionTile:
				var tile = collider as InteractionTile
				show_interact_button(tile.is_interactable(self))
				if input_handler.interact:
					tile.interact(self)


func _physics_process(_delta: float) -> void:
	if not animation_player:
		return

	var direction := input_handler.move
	if direction:
		velocity = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)

	if direction.x != 0 or direction.y != 0:
		data.last_moved_direction = direction
	direction_node.rotation = data.last_moved_direction.angle()
	move_and_slide()
	
	if input_handler.interact:
		age = 1.0 if age == 0.0 else 0.0
	
	var frameToSet = animated_sprite_2d.sprite_frames
	for i in age_sprite_frames:
		if age >= i:
			frameToSet = age_sprite_frames[i] as SpriteFrames
	animated_sprite_2d.sprite_frames = frameToSet

	if velocity.x > 0.0:
		animation_player.play("WalkRight")
	elif velocity.x < 0.0:
		animation_player.play("WalkLeft")
	elif velocity.y < 0.0:
		animation_player.play("WalkUp")
	elif velocity.y > 0.0:
		animation_player.play("WalkDown")
	else:
		animation_player.stop()
