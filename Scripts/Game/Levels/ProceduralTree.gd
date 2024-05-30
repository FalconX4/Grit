extends Node
class_name ProceduralTree

enum LeafPattern { OnePerNode, Spiral, Alternate }
enum BranchingStructure { StemSymetrical, Branch, Stem }

@export var stem_height_before_leaves = 0
@export var lower_leaves_lifespan = 0
@export var leaves_pattern = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
