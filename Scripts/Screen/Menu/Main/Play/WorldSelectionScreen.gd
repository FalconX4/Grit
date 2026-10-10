extends Control
class_name WorldSelectionScreen

@export var character_selection: CharacterSelectionScreen
@export var world_creation: WorldCreationScreen
@export var selection_choice_scene: PackedScene
@export var selection_choice_parent: Control
@export var container: Control

var choices: Array[WorldSelectionChoice]

func _ready() -> void:
	Helpers.node_disable(character_selection)
	Helpers.node_disable(world_creation)
	Pool.create(selection_choice_scene, len(WorldOverviewManager.worlds_overview))
	world_creation.on_created.connect(next)
	if Helpers.is_main_scene(self):
		if len(WorldOverviewManager.worlds_overview) == 0:
			WorldOverviewManager.create("Starting World")
			WorldOverviewManager.create("Fake world")
		if ProfileManager.current_profile.last_world_id == WorldOverviewManager.INVALID_WORLD:
			ProfileManager.current_profile.last_world_id = WorldOverviewManager.worlds_overview[0].id
		open()

func open() -> void:
	Helpers.node_enable(self)
	clear()
	if ProfileManager.current_profile.last_world_id == WorldOverviewManager.INVALID_WORLD:
		var world = WorldOverviewManager.create("Starting World")
		ProfileManager.current_profile.last_world_id = world.id
		next(world)
	else:
		for data in WorldOverviewManager.worlds_overview:
			if data.id == ProfileManager.current_profile.last_world_id:
				scene_creation(data)
		for data in WorldOverviewManager.worlds_overview:
			if data.id != ProfileManager.current_profile.last_world_id and data.profiles.find(ProfileManager.current_profile.id):
				scene_creation(data)
		for data in WorldOverviewManager.worlds_overview:
			if data.id != ProfileManager.current_profile.last_world_id and not data.profiles.find(ProfileManager.current_profile.id):
				scene_creation(data)
		if not choices.is_empty():
			choices[0].grab_click_focus()

func clear() -> void:
	for choice in choices:
		Pool.release(choice)
	choices.clear()

func scene_creation(data: WorldOverviewData) -> void:
	var choice = Pool.take(selection_choice_scene, selection_choice_parent) as WorldSelectionChoice
	choice.setup(data)
	choice.on_selected.connect(_on_selected)
	choice.on_deleted.connect(_on_deleted)
	choices.append(choice)

func _on_create() -> void:
	Helpers.node_enable(world_creation)
	Helpers.node_disable(container)

func _on_selected(selected_choice: WorldSelectionChoice) -> void:
	for choice in choices:
		if choice != selected_choice:
			choice.is_selected = false

func _on_deleted(choice: WorldSelectionChoice) -> void:
	if choice.data.id == ProfileManager.current_profile.last_world_id:
		ProfileManager.current_profile.last_world_id = WorldOverviewManager.INVALID_WORLD
	Pool.release(choice)
	choices.erase(choice)

func _on_next() -> void:
	for choice in choices:
		if choice.is_selected:
			next(choice.data)

func next(world: WorldOverviewData) -> void:
	character_selection.open(world)
	Helpers.node_disable(container)
