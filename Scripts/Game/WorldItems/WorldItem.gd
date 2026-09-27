class_name WorldItem

var body: WorldItemBody
var data: WorldItemData

func setup(_body: WorldItemBody, _data: WorldItemData) -> void:
	data = _data
	body = _body
	body.world_item = self

func create(_data: WorldItemData) -> void:
	data = _data
	body = Pool.take(data.item_data.scene, null, data.position, data.rotation)
	body.world_item = self
