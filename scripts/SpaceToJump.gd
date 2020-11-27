extends Label

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		hide()
