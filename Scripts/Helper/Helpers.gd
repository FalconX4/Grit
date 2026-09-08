class_name Helpers

static func is_main_scene(node: Node) -> bool:
	return node.get_tree().current_scene == node
