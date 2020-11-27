extends Node


var texture = preload("res://assets/clouds.png")


func _ready() -> void:
	position_clouds()


func position_clouds():
	for i in range(4):
		var spr = spawn_cloud(
			(i + 1) * get_viewport().size.x / 4 + rand_range(-20, 20),
			50 + rand_range(0, 30)
		)


func spawn_cloud(x = 0, y = 0):
	var spr = Sprite.new()
	spr.texture = texture
	spr.region_enabled = true
	spr.flip_h = randi() % 2
	spr.region_rect = Rect2(32 * (randi() % 2), 0, 32, 32)
	spr.position.x = x
	spr.position.y = y
	add_child(spr)
	spr.set_meta("distance", rand_range(4, 7))
	spr.modulate.a = 1 / spr.get_meta("distance")
	return spr
