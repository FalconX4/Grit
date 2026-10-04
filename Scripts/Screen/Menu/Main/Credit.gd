extends Control
class_name Credit

@export var label: RichTextLabel
@export var credit_text: CreditText
@export var scroll_container: ScrollContainer
@export var start_scroll_timer: float = 2.0
@export var scroll_speed: float = 200.0

var scroll_timer: float = 0.0
var can_scroll: bool = true

func _init() -> void:
	Localization.language_changed.connect(_language_changed)

func _ready() -> void:
	update_credit()

func _process(delta: float) -> void:
	if can_scroll:
		scroll_timer += delta
		if scroll_timer >= start_scroll_timer:
			scroll_container.scroll_vertical += (int)(scroll_speed * delta)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				scroll_timer = 0
				can_scroll = false
			elif event.is_released():
				can_scroll = true

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
	var text_size = label.get_theme_default_font().get_multiline_string_size(label.text)
	var min_size = size
	var new_size = Vector2(max(text_size.x, min_size.x), max(text_size.y, min_size.y))
	label.custom_minimum_size = new_size
