extends KinematicBody2D
class_name Player

signal killed

export(int, 100, 300) var jump_speed = 200
export(int, 400, 600) var gravity = 500

var velocity = Vector2() # pixels per second


func _physics_process(delta: float) -> void:
	var jumping = 0

	velocity.y += gravity * delta - jumping * jump_speed
	velocity = move_and_slide(velocity, Vector2.UP, false)


func process_jump():
	$Sprite/AnimationPlayer.stop(false)


func kill_dino():
	emit_signal("killed")
	$KilledSound.play()
