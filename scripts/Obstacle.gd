extends Area2D
class_name Obstacle

var _textures = [
	preload("res://assets/cactus1.png"),
	preload("res://assets/cactus2.png"),
	preload("res://assets/cactus3.png")
]


func _ready() -> void:
	$Sprite.texture = get_random_texture()
	$Sprite.flip_h = randi() % 2


func get_random_texture():
	return _textures[floor(rand_range(0, len(_textures) - 1))]
