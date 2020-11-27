extends CanvasLayer


func restart_game():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _input(event: InputEvent) -> void:
	if $Control.visible and event.is_action_pressed("jump"):
		restart_game()

