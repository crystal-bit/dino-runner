class_name Player extends KinematicBody2D

var velocity = Vector2(0, 0)

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
