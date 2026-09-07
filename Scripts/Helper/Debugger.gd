class_name Debugger

static func log(...args):
	var text = "Execution " + str(Engine.get_frames_drawn()) + ": "
	for arg in args:
		text += arg + " "
	text = text.trim_suffix(" ")
	print(text)

static func log_with_stack(...args):
	log.callv(args)
	print_stack()

static func log_warning(...args):
	var text = "Execution " + str(Engine.get_frames_drawn()) + ": "
	for arg in args:
		text += arg + " "
	text = text.trim_suffix(" ")
	push_warning(text)

static func log_warning_with_stack(...args):
	log_warning.callv(args)
	print_stack()

static func log_error(...args):
	var text = "Execution " + str(Engine.get_frames_drawn()) + ": "
	for arg in args:
		text += arg + " "
	text = text.trim_suffix(" ")
	push_error(text)

static func log_error_with_stack(...args):
	log_error.callv(args)
	print_stack()
