extends ConfirmationDialog
class_name LocalizedConfirmationDialog

@export var localization_key_title: LocalizedKey = LocalizedKey.new()
@export var localization_key_text: LocalizedKey = LocalizedKey.new()
@export var localization_key_ok: LocalizedKey = LocalizedKey.new(LocalizationMapNames.GENERIC_OK)
@export var localization_key_cancel: LocalizedKey = LocalizedKey.new(LocalizationMapNames.GENERIC_CANCEL)

func _ready() -> void:
	check_keys(localization_key_title.raw_key)
	check_keys(localization_key_text.raw_key)
	check_keys(localization_key_ok.raw_key)
	check_keys(localization_key_cancel.raw_key)
	_update_localization()
	visibility_changed.connect(_on_visible_changed)

func _on_visible_changed() -> void:
	if visible:
		get_cancel_button().grab_focus()
		_update_localization()

func check_keys(key: String) -> void:
	if key == tr(key):
		Debugger.log_error("No translation found for key: " + key)

func _update_localization() -> void:
	title = localization_key_title.update_key()
	dialog_text = localization_key_text.update_key()
	ok_button_text = localization_key_ok.update_key()
	cancel_button_text = localization_key_cancel.update_key()

func update_text_value_at(_value: String, ..._indexes) -> void: dialog_text = localization_key_text.update_value_at(_value, _indexes)
func update_text_localized_value_at(_localized_value: String, ..._indexes) -> void: dialog_text = localization_key_text.update_localized_value_at(_localized_value, _indexes)
func update_text_localized_key_at(_localized_key: LocalizedKey, ..._indexes) -> void: dialog_text = localization_key_text.update_localized_key_at(_localized_key, _indexes)
