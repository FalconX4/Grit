extends Node2D

@onready var sub_viewport: SubViewport = $SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture = sub_viewport.get_texture()
	await RenderingServer.frame_post_draw
	var image = texture.get_image()
	var image_texture = ImageTexture.create_from_image(image)
	var path = "res://Saved.png"
	ResourceSaver.save(image_texture, path)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
