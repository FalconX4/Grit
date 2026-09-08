extends GridContainer
class_name ItemSlotGrid

@export var item_slot: PackedScene
@export var rows: int = 5

signal item_slot_clicked(slot_index)
signal item_slot_drag_ended(slot_dragged_index, slot_final_index)

var slots : Array[ItemSlot]
var _last_selected_index: int = -1

func _ready() -> void:
	var is_main_scene = Helpers.is_main_scene(self)
	for i in rows:
		for j in columns:
			var slot = item_slot.instantiate()
			slot.setup(i * columns + j)
			slot.click.connect(on_item_slot_clicked)
			slot.drag_ended.connect(on_item_slot_drag_ended)
			slots.append(slot)
			add_child(slot, true)

			if is_main_scene:
				slot.set_random_item_data()


func on_item_slot_clicked(_slot_index: int) -> void:
	_last_selected_index = _slot_index
	item_slot_clicked.emit(_slot_index)


func on_item_slot_drag_ended(last_mouse_position: Vector2, slot_dragged_index: int) -> void:
	for i in len(slots):
		if i != slot_dragged_index and slots[i].get_global_rect().has_point(last_mouse_position):
			_last_selected_index = i
			var temp_item_data = slots[i].current_item_data
			slots[i].set_item_data(slots[slot_dragged_index].current_item_data)
			slots[slot_dragged_index].set_item_data(temp_item_data)
			slots[slot_dragged_index].selected.remove()
			slots[i].selected.add()
			item_slot_drag_ended.emit(slot_dragged_index, i)
			break


func set_random_items() -> void:
	for slot in slots:
		slot.set_random_item_data()
