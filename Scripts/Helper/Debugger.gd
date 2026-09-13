class_name Debugger

static func log(...args):
	print(get_text(args))

static func log_with_stack(...args):
	log.callv(args)
	print_stack()

static func log_warning(...args):
	push_warning(get_text(args))

static func log_warning_with_stack(...args):
	log_warning.callv(args)
	print_stack()

static func log_error(...args):
	push_error(get_text(args))

static func log_error_with_stack(...args):
	log_error.callv(args)
	print_stack()

static func get_text(args) -> String:
	var text = "Execution " + str(Engine.get_frames_drawn()) + ": "
	for arg in args:
		text += str(arg) + " "
	text = text.trim_suffix(" ")
	return text
