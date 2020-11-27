extends Node2D

onready var game = get_node("/root/Game")
var window_size
signal moved


func _ready() -> void:
	window_size = get_viewport().size



# delta is in milliseconds
func _physics_process(delta: float) -> void:
	if game:
		move(delta * game.speed)
	else:
		move(delta * 50)


# space is in pixels
func move(space):
	for obstacle in $Obstacles.get_children():
		obstacle.position.x -= space
		if obstacle.position.x < -20:
			$Obstacles.spawn_obstacle(window_size.x + 20 + rand_range(0, 160), obstacle.position.y)
			obstacle.queue_free()

	for cloud in $Clouds.get_children():
		cloud.position.x -= space / cloud.get_meta("distance")
		if cloud.position.x < -20:
			cloud.queue_free()
			$Clouds.spawn_cloud(window_size.x + 20, 10 + rand_range(0, 60))

	emit_signal("moved", space)
