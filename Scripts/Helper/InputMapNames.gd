class_name InputMapNames
	
enum InputAction {
	UI_ACCEPT,
	UI_SELECT,
	UI_CANCEL,
	UI_CLOSE_DIALOG,
	UI_FOCUS_NEXT,
	UI_FOCUS_PREV,
	UI_LEFT,
	UI_RIGHT,
	UI_UP,
	UI_DOWN,
	UI_PAGE_UP,
	UI_PAGE_DOWN,
	UI_HOME,
	UI_END,
	UI_ACCESSIBILITY_DRAG_AND_DROP,
	UI_CUT,
	UI_COPY,
	UI_FOCUS_MODE,
	UI_PASTE,
	UI_UNDO,
	UI_REDO,
	UI_TEXT_COMPLETION_QUERY,
	UI_TEXT_COMPLETION_ACCEPT,
	UI_TEXT_COMPLETION_REPLACE,
	UI_TEXT_NEWLINE,
	UI_TEXT_NEWLINE_BLANK,
	UI_TEXT_NEWLINE_ABOVE,
	UI_TEXT_INDENT,
	UI_TEXT_DEDENT,
	UI_TEXT_BACKSPACE,
	UI_TEXT_BACKSPACE_WORD,
	UI_TEXT_BACKSPACE_ALL_TO_LEFT,
	UI_TEXT_DELETE,
	UI_TEXT_DELETE_WORD,
	UI_TEXT_DELETE_ALL_TO_RIGHT,
	UI_TEXT_CARET_LEFT,
	UI_TEXT_CARET_WORD_LEFT,
	UI_TEXT_CARET_RIGHT,
	UI_TEXT_CARET_WORD_RIGHT,
	UI_TEXT_CARET_UP,
	UI_TEXT_CARET_DOWN,
	UI_TEXT_CARET_LINE_START,
	UI_TEXT_CARET_LINE_END,
	UI_TEXT_CARET_PAGE_UP,
	UI_TEXT_CARET_PAGE_DOWN,
	UI_TEXT_CARET_DOCUMENT_START,
	UI_TEXT_CARET_DOCUMENT_END,
	UI_TEXT_CARET_ADD_BELOW,
	UI_TEXT_CARET_ADD_ABOVE,
	UI_TEXT_SCROLL_UP,
	UI_TEXT_SCROLL_DOWN,
	UI_TEXT_SELECT_ALL,
	UI_TEXT_SELECT_WORD_UNDER_CARET,
	UI_TEXT_ADD_SELECTION_FOR_NEXT_OCCURRENCE,
	UI_TEXT_SKIP_SELECTION_FOR_NEXT_OCCURRENCE,
	UI_TEXT_CLEAR_CARETS_AND_SELECTION,
	UI_TEXT_TOGGLE_INSERT_MODE,
	UI_MENU,
	UI_TEXT_SUBMIT,
	UI_UNICODE_START,
	UI_GRAPH_DUPLICATE,
	UI_GRAPH_DELETE,
	UI_GRAPH_FOLLOW_LEFT,
	UI_GRAPH_FOLLOW_RIGHT,
	UI_FILEDIALOG_DELETE,
	UI_FILEDIALOG_UP_ONE_LEVEL,
	UI_FILEDIALOG_REFRESH,
	UI_FILEDIALOG_SHOW_HIDDEN,
	UI_FILEDIALOG_FIND,
	UI_FILEDIALOG_FOCUS_PATH,
	UI_SWAP_INPUT_DIRECTION,
	UI_COLORPICKER_DELETE_PRESET,
	GAME_MOVE_UP,
	GAME_MOVE_DOWN,
	GAME_MOVE_LEFT,
	GAME_MOVE_RIGHT,
	GAME_INTERACT,
	GAME_INVENTORY_BAR_1,
	GAME_INVENTORY_BAR_2,
	GAME_INVENTORY_BAR_3,
	GAME_INVENTORY_BAR_4,
	GAME_INVENTORY_BAR_5,
	GAME_INVENTORY_BAR_6,
	GAME_INVENTORY_BAR_7,
	GAME_INVENTORY_BAR_8,
	GAME_INVENTORY_BAR_9,
	GAME_INVENTORY_BAR_0,
	GAME_INVENTORY_BAR_LEFT,
	GAME_INVENTORY_BAR_RIGHT,

}

const UI_ACCEPT: StringName = &"ui_accept"
const UI_SELECT: StringName = &"ui_select"
const UI_CANCEL: StringName = &"ui_cancel"
const UI_CLOSE_DIALOG: StringName = &"ui_close_dialog"
const UI_FOCUS_NEXT: StringName = &"ui_focus_next"
const UI_FOCUS_PREV: StringName = &"ui_focus_prev"
const UI_LEFT: StringName = &"ui_left"
const UI_RIGHT: StringName = &"ui_right"
const UI_UP: StringName = &"ui_up"
const UI_DOWN: StringName = &"ui_down"
const UI_PAGE_UP: StringName = &"ui_page_up"
const UI_PAGE_DOWN: StringName = &"ui_page_down"
const UI_HOME: StringName = &"ui_home"
const UI_END: StringName = &"ui_end"
const UI_ACCESSIBILITY_DRAG_AND_DROP: StringName = &"ui_accessibility_drag_and_drop"
const UI_CUT: StringName = &"ui_cut"
const UI_COPY: StringName = &"ui_copy"
const UI_FOCUS_MODE: StringName = &"ui_focus_mode"
const UI_PASTE: StringName = &"ui_paste"
const UI_UNDO: StringName = &"ui_undo"
const UI_REDO: StringName = &"ui_redo"
const UI_TEXT_COMPLETION_QUERY: StringName = &"ui_text_completion_query"
const UI_TEXT_COMPLETION_ACCEPT: StringName = &"ui_text_completion_accept"
const UI_TEXT_COMPLETION_REPLACE: StringName = &"ui_text_completion_replace"
const UI_TEXT_NEWLINE: StringName = &"ui_text_newline"
const UI_TEXT_NEWLINE_BLANK: StringName = &"ui_text_newline_blank"
const UI_TEXT_NEWLINE_ABOVE: StringName = &"ui_text_newline_above"
const UI_TEXT_INDENT: StringName = &"ui_text_indent"
const UI_TEXT_DEDENT: StringName = &"ui_text_dedent"
const UI_TEXT_BACKSPACE: StringName = &"ui_text_backspace"
const UI_TEXT_BACKSPACE_WORD: StringName = &"ui_text_backspace_word"
const UI_TEXT_BACKSPACE_ALL_TO_LEFT: StringName = &"ui_text_backspace_all_to_left"
const UI_TEXT_DELETE: StringName = &"ui_text_delete"
const UI_TEXT_DELETE_WORD: StringName = &"ui_text_delete_word"
const UI_TEXT_DELETE_ALL_TO_RIGHT: StringName = &"ui_text_delete_all_to_right"
const UI_TEXT_CARET_LEFT: StringName = &"ui_text_caret_left"
const UI_TEXT_CARET_WORD_LEFT: StringName = &"ui_text_caret_word_left"
const UI_TEXT_CARET_RIGHT: StringName = &"ui_text_caret_right"
const UI_TEXT_CARET_WORD_RIGHT: StringName = &"ui_text_caret_word_right"
const UI_TEXT_CARET_UP: StringName = &"ui_text_caret_up"
const UI_TEXT_CARET_DOWN: StringName = &"ui_text_caret_down"
const UI_TEXT_CARET_LINE_START: StringName = &"ui_text_caret_line_start"
const UI_TEXT_CARET_LINE_END: StringName = &"ui_text_caret_line_end"
const UI_TEXT_CARET_PAGE_UP: StringName = &"ui_text_caret_page_up"
const UI_TEXT_CARET_PAGE_DOWN: StringName = &"ui_text_caret_page_down"
const UI_TEXT_CARET_DOCUMENT_START: StringName = &"ui_text_caret_document_start"
const UI_TEXT_CARET_DOCUMENT_END: StringName = &"ui_text_caret_document_end"
const UI_TEXT_CARET_ADD_BELOW: StringName = &"ui_text_caret_add_below"
const UI_TEXT_CARET_ADD_ABOVE: StringName = &"ui_text_caret_add_above"
const UI_TEXT_SCROLL_UP: StringName = &"ui_text_scroll_up"
const UI_TEXT_SCROLL_DOWN: StringName = &"ui_text_scroll_down"
const UI_TEXT_SELECT_ALL: StringName = &"ui_text_select_all"
const UI_TEXT_SELECT_WORD_UNDER_CARET: StringName = &"ui_text_select_word_under_caret"
const UI_TEXT_ADD_SELECTION_FOR_NEXT_OCCURRENCE: StringName = &"ui_text_add_selection_for_next_occurrence"
const UI_TEXT_SKIP_SELECTION_FOR_NEXT_OCCURRENCE: StringName = &"ui_text_skip_selection_for_next_occurrence"
const UI_TEXT_CLEAR_CARETS_AND_SELECTION: StringName = &"ui_text_clear_carets_and_selection"
const UI_TEXT_TOGGLE_INSERT_MODE: StringName = &"ui_text_toggle_insert_mode"
const UI_MENU: StringName = &"ui_menu"
const UI_TEXT_SUBMIT: StringName = &"ui_text_submit"
const UI_UNICODE_START: StringName = &"ui_unicode_start"
const UI_GRAPH_DUPLICATE: StringName = &"ui_graph_duplicate"
const UI_GRAPH_DELETE: StringName = &"ui_graph_delete"
const UI_GRAPH_FOLLOW_LEFT: StringName = &"ui_graph_follow_left"
const UI_GRAPH_FOLLOW_RIGHT: StringName = &"ui_graph_follow_right"
const UI_FILEDIALOG_DELETE: StringName = &"ui_filedialog_delete"
const UI_FILEDIALOG_UP_ONE_LEVEL: StringName = &"ui_filedialog_up_one_level"
const UI_FILEDIALOG_REFRESH: StringName = &"ui_filedialog_refresh"
const UI_FILEDIALOG_SHOW_HIDDEN: StringName = &"ui_filedialog_show_hidden"
const UI_FILEDIALOG_FIND: StringName = &"ui_filedialog_find"
const UI_FILEDIALOG_FOCUS_PATH: StringName = &"ui_filedialog_focus_path"
const UI_SWAP_INPUT_DIRECTION: StringName = &"ui_swap_input_direction"
const UI_COLORPICKER_DELETE_PRESET: StringName = &"ui_colorpicker_delete_preset"
const GAME_MOVE_UP: StringName = &"Game_Move_Up"
const GAME_MOVE_DOWN: StringName = &"Game_Move_Down"
const GAME_MOVE_LEFT: StringName = &"Game_Move_Left"
const GAME_MOVE_RIGHT: StringName = &"Game_Move_Right"
const GAME_INTERACT: StringName = &"Game_Interact"
const GAME_INVENTORY_BAR_1: StringName = &"Game_Inventory_Bar_1"
const GAME_INVENTORY_BAR_2: StringName = &"Game_Inventory_Bar_2"
const GAME_INVENTORY_BAR_3: StringName = &"Game_Inventory_Bar_3"
const GAME_INVENTORY_BAR_4: StringName = &"Game_Inventory_Bar_4"
const GAME_INVENTORY_BAR_5: StringName = &"Game_Inventory_Bar_5"
const GAME_INVENTORY_BAR_6: StringName = &"Game_Inventory_Bar_6"
const GAME_INVENTORY_BAR_7: StringName = &"Game_Inventory_Bar_7"
const GAME_INVENTORY_BAR_8: StringName = &"Game_Inventory_Bar_8"
const GAME_INVENTORY_BAR_9: StringName = &"Game_Inventory_Bar_9"
const GAME_INVENTORY_BAR_0: StringName = &"Game_Inventory_Bar_0"
const GAME_INVENTORY_BAR_LEFT: StringName = &"Game_Inventory_Bar_Left"
const GAME_INVENTORY_BAR_RIGHT: StringName = &"Game_Inventory_Bar_Right"


static func get_action_string(action: InputAction) -> StringName:
	match action:
		InputAction.UI_ACCEPT: return UI_ACCEPT
		InputAction.UI_SELECT: return UI_SELECT
		InputAction.UI_CANCEL: return UI_CANCEL
		InputAction.UI_CLOSE_DIALOG: return UI_CLOSE_DIALOG
		InputAction.UI_FOCUS_NEXT: return UI_FOCUS_NEXT
		InputAction.UI_FOCUS_PREV: return UI_FOCUS_PREV
		InputAction.UI_LEFT: return UI_LEFT
		InputAction.UI_RIGHT: return UI_RIGHT
		InputAction.UI_UP: return UI_UP
		InputAction.UI_DOWN: return UI_DOWN
		InputAction.UI_PAGE_UP: return UI_PAGE_UP
		InputAction.UI_PAGE_DOWN: return UI_PAGE_DOWN
		InputAction.UI_HOME: return UI_HOME
		InputAction.UI_END: return UI_END
		InputAction.UI_ACCESSIBILITY_DRAG_AND_DROP: return UI_ACCESSIBILITY_DRAG_AND_DROP
		InputAction.UI_CUT: return UI_CUT
		InputAction.UI_COPY: return UI_COPY
		InputAction.UI_FOCUS_MODE: return UI_FOCUS_MODE
		InputAction.UI_PASTE: return UI_PASTE
		InputAction.UI_UNDO: return UI_UNDO
		InputAction.UI_REDO: return UI_REDO
		InputAction.UI_TEXT_COMPLETION_QUERY: return UI_TEXT_COMPLETION_QUERY
		InputAction.UI_TEXT_COMPLETION_ACCEPT: return UI_TEXT_COMPLETION_ACCEPT
		InputAction.UI_TEXT_COMPLETION_REPLACE: return UI_TEXT_COMPLETION_REPLACE
		InputAction.UI_TEXT_NEWLINE: return UI_TEXT_NEWLINE
		InputAction.UI_TEXT_NEWLINE_BLANK: return UI_TEXT_NEWLINE_BLANK
		InputAction.UI_TEXT_NEWLINE_ABOVE: return UI_TEXT_NEWLINE_ABOVE
		InputAction.UI_TEXT_INDENT: return UI_TEXT_INDENT
		InputAction.UI_TEXT_DEDENT: return UI_TEXT_DEDENT
		InputAction.UI_TEXT_BACKSPACE: return UI_TEXT_BACKSPACE
		InputAction.UI_TEXT_BACKSPACE_WORD: return UI_TEXT_BACKSPACE_WORD
		InputAction.UI_TEXT_BACKSPACE_ALL_TO_LEFT: return UI_TEXT_BACKSPACE_ALL_TO_LEFT
		InputAction.UI_TEXT_DELETE: return UI_TEXT_DELETE
		InputAction.UI_TEXT_DELETE_WORD: return UI_TEXT_DELETE_WORD
		InputAction.UI_TEXT_DELETE_ALL_TO_RIGHT: return UI_TEXT_DELETE_ALL_TO_RIGHT
		InputAction.UI_TEXT_CARET_LEFT: return UI_TEXT_CARET_LEFT
		InputAction.UI_TEXT_CARET_WORD_LEFT: return UI_TEXT_CARET_WORD_LEFT
		InputAction.UI_TEXT_CARET_RIGHT: return UI_TEXT_CARET_RIGHT
		InputAction.UI_TEXT_CARET_WORD_RIGHT: return UI_TEXT_CARET_WORD_RIGHT
		InputAction.UI_TEXT_CARET_UP: return UI_TEXT_CARET_UP
		InputAction.UI_TEXT_CARET_DOWN: return UI_TEXT_CARET_DOWN
		InputAction.UI_TEXT_CARET_LINE_START: return UI_TEXT_CARET_LINE_START
		InputAction.UI_TEXT_CARET_LINE_END: return UI_TEXT_CARET_LINE_END
		InputAction.UI_TEXT_CARET_PAGE_UP: return UI_TEXT_CARET_PAGE_UP
		InputAction.UI_TEXT_CARET_PAGE_DOWN: return UI_TEXT_CARET_PAGE_DOWN
		InputAction.UI_TEXT_CARET_DOCUMENT_START: return UI_TEXT_CARET_DOCUMENT_START
		InputAction.UI_TEXT_CARET_DOCUMENT_END: return UI_TEXT_CARET_DOCUMENT_END
		InputAction.UI_TEXT_CARET_ADD_BELOW: return UI_TEXT_CARET_ADD_BELOW
		InputAction.UI_TEXT_CARET_ADD_ABOVE: return UI_TEXT_CARET_ADD_ABOVE
		InputAction.UI_TEXT_SCROLL_UP: return UI_TEXT_SCROLL_UP
		InputAction.UI_TEXT_SCROLL_DOWN: return UI_TEXT_SCROLL_DOWN
		InputAction.UI_TEXT_SELECT_ALL: return UI_TEXT_SELECT_ALL
		InputAction.UI_TEXT_SELECT_WORD_UNDER_CARET: return UI_TEXT_SELECT_WORD_UNDER_CARET
		InputAction.UI_TEXT_ADD_SELECTION_FOR_NEXT_OCCURRENCE: return UI_TEXT_ADD_SELECTION_FOR_NEXT_OCCURRENCE
		InputAction.UI_TEXT_SKIP_SELECTION_FOR_NEXT_OCCURRENCE: return UI_TEXT_SKIP_SELECTION_FOR_NEXT_OCCURRENCE
		InputAction.UI_TEXT_CLEAR_CARETS_AND_SELECTION: return UI_TEXT_CLEAR_CARETS_AND_SELECTION
		InputAction.UI_TEXT_TOGGLE_INSERT_MODE: return UI_TEXT_TOGGLE_INSERT_MODE
		InputAction.UI_MENU: return UI_MENU
		InputAction.UI_TEXT_SUBMIT: return UI_TEXT_SUBMIT
		InputAction.UI_UNICODE_START: return UI_UNICODE_START
		InputAction.UI_GRAPH_DUPLICATE: return UI_GRAPH_DUPLICATE
		InputAction.UI_GRAPH_DELETE: return UI_GRAPH_DELETE
		InputAction.UI_GRAPH_FOLLOW_LEFT: return UI_GRAPH_FOLLOW_LEFT
		InputAction.UI_GRAPH_FOLLOW_RIGHT: return UI_GRAPH_FOLLOW_RIGHT
		InputAction.UI_FILEDIALOG_DELETE: return UI_FILEDIALOG_DELETE
		InputAction.UI_FILEDIALOG_UP_ONE_LEVEL: return UI_FILEDIALOG_UP_ONE_LEVEL
		InputAction.UI_FILEDIALOG_REFRESH: return UI_FILEDIALOG_REFRESH
		InputAction.UI_FILEDIALOG_SHOW_HIDDEN: return UI_FILEDIALOG_SHOW_HIDDEN
		InputAction.UI_FILEDIALOG_FIND: return UI_FILEDIALOG_FIND
		InputAction.UI_FILEDIALOG_FOCUS_PATH: return UI_FILEDIALOG_FOCUS_PATH
		InputAction.UI_SWAP_INPUT_DIRECTION: return UI_SWAP_INPUT_DIRECTION
		InputAction.UI_COLORPICKER_DELETE_PRESET: return UI_COLORPICKER_DELETE_PRESET
		InputAction.GAME_MOVE_UP: return GAME_MOVE_UP
		InputAction.GAME_MOVE_DOWN: return GAME_MOVE_DOWN
		InputAction.GAME_MOVE_LEFT: return GAME_MOVE_LEFT
		InputAction.GAME_MOVE_RIGHT: return GAME_MOVE_RIGHT
		InputAction.GAME_INTERACT: return GAME_INTERACT
		InputAction.GAME_INVENTORY_BAR_1: return GAME_INVENTORY_BAR_1
		InputAction.GAME_INVENTORY_BAR_2: return GAME_INVENTORY_BAR_2
		InputAction.GAME_INVENTORY_BAR_3: return GAME_INVENTORY_BAR_3
		InputAction.GAME_INVENTORY_BAR_4: return GAME_INVENTORY_BAR_4
		InputAction.GAME_INVENTORY_BAR_5: return GAME_INVENTORY_BAR_5
		InputAction.GAME_INVENTORY_BAR_6: return GAME_INVENTORY_BAR_6
		InputAction.GAME_INVENTORY_BAR_7: return GAME_INVENTORY_BAR_7
		InputAction.GAME_INVENTORY_BAR_8: return GAME_INVENTORY_BAR_8
		InputAction.GAME_INVENTORY_BAR_9: return GAME_INVENTORY_BAR_9
		InputAction.GAME_INVENTORY_BAR_0: return GAME_INVENTORY_BAR_0
		InputAction.GAME_INVENTORY_BAR_LEFT: return GAME_INVENTORY_BAR_LEFT
		InputAction.GAME_INVENTORY_BAR_RIGHT: return GAME_INVENTORY_BAR_RIGHT

		_:
			push_error("Unknown InputAction enum value: %d" % action)
			return &""


static func get_all_actions() -> Array[StringName]:
	return [
		UI_ACCEPT,
		UI_SELECT,
		UI_CANCEL,
		UI_CLOSE_DIALOG,
		UI_FOCUS_NEXT,
		UI_FOCUS_PREV,
		UI_LEFT,
		UI_RIGHT,
		UI_UP,
		UI_DOWN,
		UI_PAGE_UP,
		UI_PAGE_DOWN,
		UI_HOME,
		UI_END,
		UI_ACCESSIBILITY_DRAG_AND_DROP,
		UI_CUT,
		UI_COPY,
		UI_FOCUS_MODE,
		UI_PASTE,
		UI_UNDO,
		UI_REDO,
		UI_TEXT_COMPLETION_QUERY,
		UI_TEXT_COMPLETION_ACCEPT,
		UI_TEXT_COMPLETION_REPLACE,
		UI_TEXT_NEWLINE,
		UI_TEXT_NEWLINE_BLANK,
		UI_TEXT_NEWLINE_ABOVE,
		UI_TEXT_INDENT,
		UI_TEXT_DEDENT,
		UI_TEXT_BACKSPACE,
		UI_TEXT_BACKSPACE_WORD,
		UI_TEXT_BACKSPACE_ALL_TO_LEFT,
		UI_TEXT_DELETE,
		UI_TEXT_DELETE_WORD,
		UI_TEXT_DELETE_ALL_TO_RIGHT,
		UI_TEXT_CARET_LEFT,
		UI_TEXT_CARET_WORD_LEFT,
		UI_TEXT_CARET_RIGHT,
		UI_TEXT_CARET_WORD_RIGHT,
		UI_TEXT_CARET_UP,
		UI_TEXT_CARET_DOWN,
		UI_TEXT_CARET_LINE_START,
		UI_TEXT_CARET_LINE_END,
		UI_TEXT_CARET_PAGE_UP,
		UI_TEXT_CARET_PAGE_DOWN,
		UI_TEXT_CARET_DOCUMENT_START,
		UI_TEXT_CARET_DOCUMENT_END,
		UI_TEXT_CARET_ADD_BELOW,
		UI_TEXT_CARET_ADD_ABOVE,
		UI_TEXT_SCROLL_UP,
		UI_TEXT_SCROLL_DOWN,
		UI_TEXT_SELECT_ALL,
		UI_TEXT_SELECT_WORD_UNDER_CARET,
		UI_TEXT_ADD_SELECTION_FOR_NEXT_OCCURRENCE,
		UI_TEXT_SKIP_SELECTION_FOR_NEXT_OCCURRENCE,
		UI_TEXT_CLEAR_CARETS_AND_SELECTION,
		UI_TEXT_TOGGLE_INSERT_MODE,
		UI_MENU,
		UI_TEXT_SUBMIT,
		UI_UNICODE_START,
		UI_GRAPH_DUPLICATE,
		UI_GRAPH_DELETE,
		UI_GRAPH_FOLLOW_LEFT,
		UI_GRAPH_FOLLOW_RIGHT,
		UI_FILEDIALOG_DELETE,
		UI_FILEDIALOG_UP_ONE_LEVEL,
		UI_FILEDIALOG_REFRESH,
		UI_FILEDIALOG_SHOW_HIDDEN,
		UI_FILEDIALOG_FIND,
		UI_FILEDIALOG_FOCUS_PATH,
		UI_SWAP_INPUT_DIRECTION,
		UI_COLORPICKER_DELETE_PRESET,
		GAME_MOVE_UP,
		GAME_MOVE_DOWN,
		GAME_MOVE_LEFT,
		GAME_MOVE_RIGHT,
		GAME_INTERACT,
		GAME_INVENTORY_BAR_1,
		GAME_INVENTORY_BAR_2,
		GAME_INVENTORY_BAR_3,
		GAME_INVENTORY_BAR_4,
		GAME_INVENTORY_BAR_5,
		GAME_INVENTORY_BAR_6,
		GAME_INVENTORY_BAR_7,
		GAME_INVENTORY_BAR_8,
		GAME_INVENTORY_BAR_9,
		GAME_INVENTORY_BAR_0,
		GAME_INVENTORY_BAR_LEFT,
		GAME_INVENTORY_BAR_RIGHT,

	]
