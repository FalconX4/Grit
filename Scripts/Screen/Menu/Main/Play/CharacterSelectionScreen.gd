extends Control
class_name CharacterSelectionScreen

@export var character_creation: CharacterCreationScreen
@export var selection_choice_scene: PackedScene
@export var selection_choice_parent: Control
@export var container: Control

var choices: Array[CharacterSelectionChoice]
var world_overview_data: WorldOverviewData
var world_data: WorldData

func _ready() -> void:
	character_creation.on_create.connect(_on_created)
	Helpers.node_disable(character_creation)
	Pool.create(selection_choice_scene, len(WorldOverviewManager.worlds_overview))
	if Helpers.is_main_scene(self):
		if len(WorldOverviewManager.worlds_overview) == 0:
			WorldOverviewManager.create("Starting World")
		if ProfileManager.current_profile.last_world_id == WorldOverviewManager.INVALID_WORLD:
			ProfileManager.current_profile.last_world_id = WorldOverviewManager.worlds_overview[0].id
		world_data = WorldManager._load_from_overview(WorldOverviewManager.worlds_overview[0])
		var original_character_data = CharacterData.new(0, "Default", null)
		var player_data = PlayerData.new(0, ProfileManager.current_profile.id, 0)
		world_data.players.append(player_data)
		world_data.characters.append(original_character_data)
		open(WorldOverviewManager.worlds_overview[0])

func open(world_overview: WorldOverviewData) -> void:
	Helpers.node_enable(self)
	var found = false
	world_overview_data = world_overview
	clear()
	if world_overview_data.profiles.find(ProfileManager.current_profile.id):
		world_data = WorldManager._load_from_overview(world_overview_data)
		for data in world_data.players:
			if data.profile_id == ProfileManager.current_profile.id and data.id == ProfileManager.current_profile.last_player_id:
				scene_creation(data)
				found = true
		for data in world_data.players:
			if data.profile_id == ProfileManager.current_profile.id and data.id != ProfileManager.current_profile.last_player_id:
				scene_creation(data)
				found = true
		if not choices.is_empty():
			choices[0].grab_click_focus()
	if not found:
		_on_create()

func clear() -> void:
	for choice in choices:
		Pool.release(choice)
	choices.clear()

func scene_creation(data: PlayerData) -> void:
	var choice = Pool.take(selection_choice_scene, selection_choice_parent) as CharacterSelectionChoice
	choice.setup(data, world_data)
	choice.on_selected.connect(_on_selected)
	choice.on_deleted.connect(_on_deleted)
	choice.setup(data, world_data)

func _on_create() -> void:
	Helpers.node_enable(character_creation)
	Helpers.node_disable(container)

func _on_created(data: CharacterData) -> void:
	var player_data = PlayerData.new(0, ProfileManager.current_profile.id, data.id)
	world_data.players.append(player_data)
	world_data.characters.append(data)
	play(player_data)

func _on_selected(selected_choice: CharacterSelectionChoice) -> void:
	for choice in choices:
		if choice != selected_choice:
			choice.is_selected = false

func _on_deleted(choice: WorldSelectionChoice) -> void:
	if choice.data.id == ProfileManager.current_profile.last_player_id:
		ProfileManager.current_profile.last_player_id = WorldOverviewManager.INVALID_WORLD
	Pool.release(choice)
	choices.erase(choice)

func _on_play() -> void:
	for choice in choices:
		if choice.is_selected:
			play(choice.data)

func play(data: PlayerData) -> void:
	# TODO FEATURE PLAY: Go into game
	pass
