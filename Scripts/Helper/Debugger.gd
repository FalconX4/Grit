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
