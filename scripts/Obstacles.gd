extends Node


func _ready() -> void:
	spawn_obstacle(300, 125)
	spawn_obstacle(400, 125)


#func position_obstacles():
#	for i in range(1):
#		var spr = spawn_obstacle((i + 1) * get_viewport().size.x / 2 + rand_range(-20, 20), 125)


func spawn_obstacle(x = 0, y = 0):
	var spr = preload("res://scenes/Obstacle.tscn").instance()
	add_child(spr)
	spr.position.x = x
	spr.position.y = y
	return spr

