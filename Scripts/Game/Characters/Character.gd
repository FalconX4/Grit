extends CharacterBody2D
class_name Character

const SPEED = 150.0
@onready var character_input: CharacterInput = $CharacterInput
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_button: Button = $InteractButton
@onready var interact_trigger: ShapeCast2D = $DirectionNode/InteractTrigger
@onready var direction_node: Node2D = $DirectionNode
@export var age_sprite_frames: Dictionary
@export var age = 0.0

var items : Array[ItemData]
var selected_item_index = -1
var last_moved_direction : Vector2

func add_item(item: ItemData): items.append(item)
func remove_item(index: int): items.remove_at(index)
func show_interact_button(show: bool): interact_button.visible = show

func update_input_buttons(): update_input_button(interact_button, "Interact")
func update_input_button(button: Button, input_action: String):
	if character_input.using_controller:
		for event in InputMap.action_get_events(input_action):
			if event is InputEventJoypadButton:
				button.text = Helpers.controller_input_to_text(event, character_input.last_device_id)
				break
			elif event is InputEventJoypadMotion:
				button.text = Helpers.controller_input_to_text(event, character_input.last_device_id)
				break
	else:
		for event in InputMap.action_get_events(input_action):
			if event is InputEventKey:
				button.text = (event as InputEventKey).as_text_physical_keycode()
				break
			elif event is InputEventMouseButton:
				button.text = str((event as InputEventMouseButton).button_index)
				break
	
func _ready() -> void:
	add_item(DataManager.itemsData.items[0])
	update_input_buttons()

func _process(_delta: float) -> void:
	if character_input.was_using_controller != character_input.using_controller:
		update_input_buttons()
	if character_input.inventory >= 0:
		selected_item_index = character_input.inventory

	if interact_trigger.is_colliding():
		for i in interact_trigger.get_collision_count():
			var collider = interact_trigger.get_collider(i)
			if collider is InteractionTile:
				var tile = collider as InteractionTile
				show_interact_button(tile.is_interactable(self))
				if character_input.interact:
					tile.interact(self)

func _physics_process(_delta: float) -> void:
	var direction := character_input.move
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if direction.x != 0 or direction.y != 0:
		last_moved_direction = direction
	direction_node.rotation = last_moved_direction.angle()
	move_and_slide()
	
	if character_input.interact:
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
