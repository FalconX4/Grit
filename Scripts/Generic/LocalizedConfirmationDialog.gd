extends ConfirmationDialog
class_name LocalizedConfirmationDialog

@export var localization_key_title: String
@export var localization_key_text: String
@export var localization_key_ok: String = LocalizationMapNames.GENERIC_OK
@export var localization_key_cancel: String = LocalizationMapNames.GENERIC_CANCEL
@export var localization_key_text_params: Array[String]

var localized_params: Array[String]

func _ready() -> void:
	check_keys(localization_key_title)
	check_keys(localization_key_text)
	check_keys(localization_key_ok)
	check_keys(localization_key_cancel)
	title = localization_key_title
	dialog_text = localization_key_text
	ok_button_text = localization_key_ok
	cancel_button_text = localization_key_cancel
	visibility_changed.connect(_on_visible_changed)

func _on_visible_changed() -> void:
	if visible:
		get_cancel_button().grab_focus()
		if localization_key_text_params.is_empty():
			return
		localized_params.clear()
		for i in range(localization_key_text_params.size() - 1, -1, -1):
			var tr_param = tr(localization_key_text_params[i])
			if tr_param.contains("%s"):
				if localized_params.is_empty():
					Debugger.log_error("Find %s in a param with no params after to add to it...")
					break
				localized_params.reverse()
				tr_param = tr_param % localized_params
				localized_params.clear()
			localized_params.append(tr_param)
		localized_params.reverse()
		dialog_text = tr(localization_key_text) % localized_params

func check_keys(key: String) -> void:
	if key == tr(key):
		Debugger.log_error("No translation found for key: " + key)
