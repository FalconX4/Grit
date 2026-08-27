@tool
extends EditorPlugin


const items_res_path: String = "res://Data/Game/Items/Items.tres"
const foods_res_path: String = "res://Data/Game/Items/Foods/"
const seeds_res_path: String = "res://Data/Game/Items/Seeds/"
const foods_csv_path: String = "res://addons/ItemParser/Foods.csv"
const seeds_csv_path: String = "res://addons/ItemParser/Seeds.csv"

enum FoodData
{
	Name,
	Description,
	Inventory_Image,
	Journal_Image
}

enum SeedData
{
	Name,
	Description,
	Inventory_Image,
	Journal_Image,
	Frames_Each_Step,
	Pivot_Each_Step,
	Age_Each_Step,
	Collision_Each_Step,
	GrasS_Area_Each_Step,
	Items_To_Give_Each_Step
}

func _enter_tree() -> void:
	add_tool_menu_item("Parse Database", _on_button_pressed)

func _exit_tree():
	remove_tool_menu_item("Parse Database")

func _on_button_pressed() -> void:
	print("Beginning")
	var itemsData : ItemsListData
	if FileAccess.file_exists(items_res_path):
		itemsData = ResourceLoader.load(items_res_path) as ItemsListData
		itemsData.items.clear()
	else:
		itemsData = ItemsListData.new()

	var localization_names = LocalizationMapNames.get_all_actions()
	load_foods(itemsData, localization_names)
	load_seeds(itemsData, localization_names)
	ResourceSaver.save(itemsData, items_res_path)
	print("Finished")

func load_foods(itemsData: ItemsListData, localization_names: Array) -> void:
	print("Beginning foods")
	OS.move_to_trash(ProjectSettings.globalize_path(foods_res_path))
	DirAccess.make_dir_absolute(ProjectSettings.globalize_path(foods_res_path))
	var file = FileAccess.open(foods_csv_path, FileAccess.READ)
	print(file)
	var line = file.get_line()
	line = file.get_line()
	while not file.eof_reached():
		var lineSplit = line.split(";")
		var item : ItemFoodData = ItemFoodData.new()
		item.name = lineSplit[FoodData.Name]
		item.description = lineSplit[FoodData.Description]
		item.inventory_image = load(lineSplit[FoodData.Inventory_Image])
		item.journal_image = load(lineSplit[FoodData.Journal_Image])
		validate_food(line, item, localization_names)
		var item_path = foods_res_path + item.name.erase(len(item.name) - len("_NAME"), len("_NAME")).to_lower() + ".tres"
		ResourceSaver.save(item, item_path)
		itemsData.items.append(ResourceLoader.load(item_path))
		line = file.get_line()
	file.close()
	print("Finished foods")

func load_seeds(itemsData: ItemsListData, localization_names: Array) -> void:
	print("Beginning seeds")
	OS.move_to_trash(ProjectSettings.globalize_path(seeds_res_path))
	DirAccess.make_dir_absolute(ProjectSettings.globalize_path(seeds_res_path))
	var file = FileAccess.open(seeds_csv_path, FileAccess.READ)
	var line = file.get_line()
	line = file.get_line()
	while not file.eof_reached():
		var lineSplit = line.split(";")
		var item : ItemSeedData = ItemSeedData.new()
		item.name = lineSplit[SeedData.Name]
		item.description = lineSplit[SeedData.Description]
		item.inventory_image = load(lineSplit[SeedData.Inventory_Image])
		item.journal_image = load(lineSplit[SeedData.Journal_Image])
		var frame_array_res = str_to_var(lineSplit[SeedData.Frames_Each_Step])
		item.frames_each_step.clear()
		for res in frame_array_res:
			item.frames_each_step.append(load(res))
		item.pivot_each_step.assign(str_to_var(lineSplit[SeedData.Pivot_Each_Step]))
		item.age_each_step.assign(str_to_var(lineSplit[SeedData.Age_Each_Step]))
		item.collision_each_step.assign(str_to_var(lineSplit[SeedData.Collision_Each_Step]))
		item.grass_area_each_step.assign(str_to_var(lineSplit[SeedData.GrasS_Area_Each_Step]))
		var item_array_res = str_to_var(lineSplit[SeedData.Items_To_Give_Each_Step])
		item.items_to_give_each_step.clear()
		for res in item_array_res:
			item.items_to_give_each_step.append(load(res))
		validate_seed(line, item, localization_names)
		var item_path = seeds_res_path + item.name.erase(len(item.name) - len("_NAME"), len("_NAME")).to_lower() + ".tres"
		ResourceSaver.save(item, item_path)
		itemsData.items.append(ResourceLoader.load(item_path))
		line = file.get_line()
	file.close()
	print("Finished seeds")

func validate_food(line: String, item: ItemFoodData, localization_names: Array) -> void:
	if item.name == "" or item.description == "" or item.inventory_image == null or item.journal_image == null:
		printerr("Validation failed: Missing required fields for food item: %s" % line)
		return

	if item.name not in localization_names:
		printerr("Validation failed: Name '%s' not found in localization map for food item: %s" % [item.name, line])
	if item.description not in localization_names:
		printerr("Validation failed: Description '%s' not found in localization map for food item: %s" % [item.description, line])
	if item.inventory_image.resource_path == "" or item.journal_image.resource_path == "":
		printerr("Validation failed: Missing resource paths for food item: %s" % line)

func validate_seed(line: String, item: ItemSeedData, localization_names: Array) -> void:
	if item.name == "" or item.description == "" or item.inventory_image == null or item.journal_image == null or item.frames_each_step == null or item.pivot_each_step == null or item.age_each_step == null or item.collision_each_step == null or item.grass_area_each_step == null or item.items_to_give_each_step == null:
		printerr("Validation failed: Missing required fields for seed item: %s" % line)
		return

	if item.name not in localization_names:
		printerr("Validation failed: Name '%s' not found in localization map for seed item: %s" % [item.name, line])
	if item.description not in localization_names:
		printerr("Validation failed: Description '%s' not found in localization map for seed item: %s" % [item.description, line])
	if item.inventory_image.resource_path == "" or item.journal_image.resource_path == "":
		printerr("Validation failed: Missing resource paths for seed item: %s" % line)
	if item.frames_each_step.size() == 0 or item.pivot_each_step.size() == 0 or item.age_each_step.size() == 0 or item.collision_each_step.size() == 0 or item.grass_area_each_step.size() == 0 or item.items_to_give_each_step.size() == 0:
		printerr("Validation failed: Incomplete data for seed item: %s" % line)
	for res in item.frames_each_step:
		if res == null or res.resource_path == "":
			printerr("Validation failed: Invalid frame data for seed item: %s" % line)
	for pivot in item.pivot_each_step:
		if pivot == null:
			printerr("Validation failed: Invalid pivot data for seed item: %s" % line)
	for age in item.age_each_step:
		if age == null:
			printerr("Validation failed: Invalid age data for seed item: %s" % line)
	for collision in item.collision_each_step:
		if collision == null:
			printerr("Validation failed: Invalid collision data for seed item: %s" % line)
	for grass in item.grass_area_each_step:
		if grass == null:
			printerr("Validation failed: Invalid grass area data for seed item: %s" % line)
	for res in item.items_to_give_each_step:
		if res == null or res.resource_path == "":
			printerr("Validation failed: Invalid item data for seed item: %s" % line)
