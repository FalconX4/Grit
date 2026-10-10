extends Control
class_name CharacterSelectionChoice

@export var name_label: Label
@export var warning_label: Label
@export var character_sprite: AnimatedSprite2D
@export var selection_frame: NinePatchRect
@export var confirm_delete_dialog: LocalizedConfirmationDialog

signal on_selected(choice: CharacterSelectionChoice)
signal on_deleted(choice: CharacterSelectionChoice)

var is_selected = false
var world_data: WorldData
var player_data: PlayerData
var original_character_data: CharacterData
var last_played_character_data: CharacterData

func _ready() -> void:
	confirm_delete_dialog.confirmed.connect(_on_delete)
	Helpers.node_disable(warning_label)
	Helpers.node_disable(selection_frame)
	if Helpers.is_main_scene(self):
		if len(WorldOverviewManager.worlds_overview) == 0:
			WorldOverviewManager.create("Starting World")
		if ProfileManager.current_profile.last_world_id == WorldOverviewManager.INVALID_WORLD:
			ProfileManager.current_profile.last_world_id = WorldOverviewManager.worlds_overview[0].id
		world_data = WorldManager._load_from_overview(WorldOverviewManager.worlds_overview[0])
		original_character_data = CharacterData.new(0, "Default", null)
		last_played_character_data = original_character_data
		player_data = PlayerData.new(0, ProfileManager.current_profile.id, 0)
		world_data.players.append(player_data)
		world_data.characters.append(original_character_data)
		setup(player_data, world_data)

func _process(_delta: float) -> void:
	Helpers.node_process_each_frame(selection_frame, is_selected)

func _on_selected() -> void:
	is_selected = true
	on_selected.emit(self)

func _on_try_delete() -> void:
	confirm_delete_dialog.localization_key_text_params[1] = original_character_data.name
	confirm_delete_dialog.popup_centered()

func _on_delete() -> void:
	world_data.remove_player_data(player_data)
	on_deleted.emit(self)

func setup(_player_data: PlayerData, _world_data: WorldData) -> void:
	player_data = _player_data
	world_data = _world_data
	original_character_data = world_data.find_character_data(player_data.original_character_id)
	last_played_character_data = world_data.find_character_data(player_data.last_character_id)
	if already_used_character(last_played_character_data):
		Helpers.node_enable(warning_label)
		setup_character(original_character_data)
	else:
		Helpers.node_disable(warning_label)
		setup_character(last_played_character_data)

func already_used_character(character_data: CharacterData) -> bool:
	for data in world_data.players:
		if data.is_playing and data.last_character_id == character_data.id:
			return true
	return false

func setup_character(character_data: CharacterData) -> void:
	name_label.text = character_data.name
	character_sprite.sprite_frames = character_data.sprite
