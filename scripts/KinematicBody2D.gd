extends KinematicBody2D
class_name Player

var velocity = Vector2(0, 0)
var gravity = 300

signal killed

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			$JumpSound.play()
			velocity.y = -200
	else:
		velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Hitbox_area_entered(area: Area2D) -> void:
	if area is Obstacle:
		emit_signal("killed")
		$KilledSound.play()
