extends Node
class_name CharacterInput

@export var is_player : bool
var move : Vector2
var inventory = -1
var interact : bool
var was_using_controller : bool
var using_controller : bool
var last_device_id : int

func _input(event: InputEvent) -> void:
	was_using_controller = using_controller
	using_controller = event is InputEventJoypadButton or event is InputEventJoypadMotion
	last_device_id = event.device

func _process(_delta: float) -> void:
	inventory = -1
	if is_player:
		move = Input.get_vector("Move Left", "Move Right", "Move Up", "Move Down")
		interact = Input.is_action_just_pressed("Interact")
		if Input.is_action_just_pressed("Inventory Left"):
			inventory = 9 if inventory <= 0 else inventory - 1
		if Input.is_action_just_pressed("Inventory Right"):
			inventory = 0 if inventory >= 9 else inventory + 1
		for i in 10:
			if Input.is_action_just_pressed("Inventory " + str(i)):
				inventory = i - 1 if i != 0 else 9
