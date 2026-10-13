extends Node

enum MenuType
{
	Main,
	PlayChoice,
	WorldSelection,
	WorldCreation,
	CharacterSelection,
	CharacterCreation,
	Options,
	Credit,
}

var menu_dict: Dictionary[MenuType, BaseMenu]
var menu_stack: Array[BaseMenu]
var menu_seen: Array[BaseMenu]

func subscribe(menu: BaseMenu) -> void:
	menu_dict[menu.type] = menu

func unsubscribe(menu: BaseMenu) -> void:
	menu_dict.erase(menu.type)

func back() -> void:
	menu_stack[-1].close()
	menu_stack.remove_at(-1)
	if menu_stack.is_empty():
		menu_seen.remove_at(-1)
		if menu_seen.is_empty():
			get_tree().quit()
		else:
			var last_menu_seen = menu_seen[-1]
			menu_seen.remove_at(-1)
			stack_open(last_menu_seen.type)
	else:
		menu_stack[-1].returned()

func close_all_stack_open(menu_type: MenuType) -> void:
	while not menu_stack.is_empty():
		menu_stack[-1].close()
		menu_stack.remove_at(-1)
	stack_open(menu_type)

func stack_close_open(menu_type: MenuType) -> void:
	menu_stack[-1].close()
	menu_stack.remove_at(-1)
	stack_open(menu_type)

func stack_open(menu_type: MenuType) -> void:
	var menu = menu_dict[menu_type]
	if menu_stack.is_empty():
		menu_seen.append(menu)
	menu_stack.append(menu)
	menu.open()
	
