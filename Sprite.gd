extends Sprite

onready var player: KinematicBody2D = get_parent()

func _process(delta: float) -> void:
	if player.is_on_floor():
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play()
