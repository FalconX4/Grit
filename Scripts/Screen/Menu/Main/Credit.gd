extends Control
class_name Credit

@export var label: RichTextLabel
@export var credit_text: CreditText

func _init() -> void:
	Localization.language_changed.connect(_language_changed)

func _process(delta: float) -> void:
	update_credit()

func _language_changed(_old_language: String, _new_language: String) -> void: update_credit()
func update_credit() -> void:
	label.text = ""
	for i in len(credit_text.categories):
		label.text += credit_text.category_title_prefix + tr(credit_text.categories[i].title) + credit_text.category_title_suffix + "\n"
		for _name in credit_text.categories[i].names:
			label.text += _name.replace("[","[lb]") + "\n"
		if i < len(credit_text.categories) - 1:
			for j in credit_text.category_line_padding:
				label.text += "\n"
