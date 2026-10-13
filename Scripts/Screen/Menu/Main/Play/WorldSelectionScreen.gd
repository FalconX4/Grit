extends BaseMenu
class_name WorldSelectionScreen

@export var character_selection: CharacterSelectionScreen
@export var world_creation: WorldCreationScreen
@export var selection_choice_scene: PackedScene
@export var selection_choice_parent: Control
@export var container: Control

var choices: Array[WorldSelectionChoice]

func _init() -> void:
	type = MenuManager.MenuType.WorldSelection

func _enter_tree() -> void:
	if Helpers.is_main_scene(self):
		if len(WorldOverviewManager.worlds_overview) == 0:
			WorldOverviewManager.create("Starting World")
			WorldOverviewManager.create("Fake world")
		if ProfileManager.current_profile.last_world_id == WorldOverviewManager.INVALID_WORLD:
			ProfileManager.current_profile.last_world_id = WorldOverviewManager.worlds_overview[0].id
	super._enter_tree()

func _ready() -> void:
	Helpers.node_disable(character_selection)
	Helpers.node_disable(world_creation)
	Pool.create(selection_choice_scene, len(WorldOverviewManager.worlds_overview))
	world_creation.on_created.connect(next)
	super._ready()

func open() -> void:
	clear()
	if ProfileManager.current_profile.last_world_id == WorldOverviewManager.INVALID_WORLD:
		var world = WorldOverviewManager.create("Starting World")
		ProfileManager.current_profile.last_world_id = world.id
		ProfileManager.save()
		super.open()
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
		super.open()
		if not choices.is_empty():
			choices[0].is_selected = true
			choices[0].grab_focus()

func clear() -> void:
	for choice in choices:
		choice.on_selected.disconnect(_on_selected)
		choice.on_deleted.disconnect(_on_deleted)
		Pool.release(choice)
	choices.clear()

func scene_creation(data: WorldOverviewData) -> void:
	var choice = Pool.take(selection_choice_scene, selection_choice_parent) as WorldSelectionChoice
	choice.setup(data)
	choice.on_selected.connect(_on_selected)
	choice.on_deleted.connect(_on_deleted)
	choices.append(choice)

func _on_create() -> void:
	stack_open(MenuManager.MenuType.WorldCreation)

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
	character_selection.set_world(world)
	stack_open(MenuManager.MenuType.CharacterSelection)
