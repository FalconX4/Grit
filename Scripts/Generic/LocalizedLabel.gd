extends Label
class_name LocalizedLabel

@export var localization_key: LocalizedKey = LocalizedKey.new()
@export var update_on_visible_change: bool
@export var update_on_language_change: bool

func _init() -> void:
	if localization_key and not localization_key.params.is_empty():
		if update_on_language_change:
			Localization.language_changed.connect(_update_localization)
		elif update_on_visible_change:
			visibility_changed.connect(_on_visible_changed)

func _ready() -> void:
	if localization_key.raw_key == tr(localization_key.raw_key):
		Debugger.log_error("No translation found for key: " + localization_key.raw_key)
	else:
		text = localization_key.update_key()

func _on_visible_changed() -> void:
	if visible:
		_update_localization()

func _update_localization() -> void: text = localization_key.update_key()
func update_value_at(_value: String, ..._indexes) -> void: text = localization_key.update_value_at(_value, _indexes)
func update_localized_value_at(_localized_value: String, ..._indexes) -> void: text = localization_key.update_localized_value_at(_localized_value, _indexes)
func update_localized_key_at(_localized_key: LocalizedKey, ..._indexes) -> void: text = localization_key.update_localized_key_at(_localized_key, _indexes)
