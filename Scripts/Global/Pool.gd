extends Node

var _pool: Dictionary
var _scene_nodes_match: Dictionary
var _scene_parent_match: Dictionary[PackedScene, Node]
var _node_scene_match: Dictionary[Node, PackedScene]

func create(scene: PackedScene, count: int) -> void:
	var queue = _pool.get(scene)
	if queue == null:
		var parent_node = create_parent(scene)
		for i in count:
			create_disabled_node(scene, parent_node, i)
	else:
		var queue_count = len(queue)
		for i in count - queue_count:
			create_disabled_node(scene, _scene_parent_match[scene], queue_count + i)

func create_parent(scene: PackedScene) -> Node:
	var parent_node = Node.new()
	parent_node.name = scene.resource_path.get_file().get_basename()
	add_child(parent_node)
	_scene_parent_match[scene] = parent_node
	_pool[scene] = []
	_scene_nodes_match[scene] = []
	return parent_node


func create_disabled_node(scene: PackedScene, parent_node: Node, index: int) -> Node:
	var node = scene.instantiate() as Node
	setup_node(node, scene, parent_node, parent_node.name + str(index))
	_pool[scene].append(node)
	Helpers.node_disable(node)
	return node


func setup_node(node: Node, scene: PackedScene, parent: Node, node_name: String) -> void:
	node.name = node_name
	_node_scene_match[node] = scene
	_scene_nodes_match[scene].append(node)
	parent.add_child(node)


func release(node: Node) -> void:
	Helpers.node_disable(node)
	var result = _node_scene_match.get(node)
	if result != null:
		_pool[result].append(node)
		node.reparent(_scene_parent_match[result])


func take(scene: PackedScene, parent: Node = null, position: Vector2 = Vector2.ZERO, rotation: float = 0.0, scale: Vector2 = Vector2.ZERO) -> Node:
	var queue = _pool.get(scene)
	var node_exist = queue != null and len(queue) > 0
	var node = queue.pop_back() if node_exist else scene.instantiate()
	if not node_exist:
		if queue == null:
			create_parent(scene)
		var parent_node = _scene_parent_match[scene]
		setup_node(node, scene, parent_node if parent == null else parent, parent_node.name + str(len(_scene_nodes_match[scene])))
	elif parent != null:
		node.reparent(parent)

	if node is Node2D or node is Control:
		node.position = position
		node.rotation_degrees = rotation
		node.scale = scale
	Helpers.node_enable(node)
	return node
