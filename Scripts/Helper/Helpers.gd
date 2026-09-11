class_name Helpers

static func is_main_scene(node: Node) -> bool:
	return node.get_tree().current_scene == node

static func node_enable(node: Node) -> void: node_process(node, true)
static func node_disable(node: Node) -> void: node_process(node, false)
static func node_process(node: Node, enable: bool) -> void:
	node.set_process(enable)
	node.set_physics_process(enable)
	node.set_process_input(enable)
	node.set_process_shortcut_input(enable)
	node.set_process_unhandled_input(enable)
	node.set_process_unhandled_key_input(enable)
	if node is CanvasItem:
		node.visible = enable
