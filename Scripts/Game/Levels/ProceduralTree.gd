extends Node
class_name ProceduralTree

enum LeafPattern { OnePerNode, Spiral, Alternate }
enum BranchingStructure { StemSymetrical, Branch, Stem }

@export var leafPatten = LeafPattern.OnePerNode
@export var branchingStructure = BranchingStructure.StemSymetrical
@export var stem_height_before_leaves = 0
@export var lower_leaves_lifespan = 0
@export var leaves_pattern = 0
@export var growing_speed = 1

var age = 0

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	age = age + growing_speed * delta
	process_tree(delta)

func process_tree(delta: float) -> void:
	pass
