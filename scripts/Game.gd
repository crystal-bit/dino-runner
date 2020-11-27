extends Node2D

var current_score: float
var speed = 90 # pixel per second
const MAX_SPEED = 250

export var god_mode = true


func _init() -> void:
	randomize()


func _ready() -> void:
	$Background.connect("moved", self, "on_moved")
	increase_speed_every(2.5)
	set_godmode(god_mode)
	if god_mode:
		$GUI/SpaceToJump.hide()


func on_moved(movement):
	# update the score
	var points_per_pixel = 0.1 * get_points_multiplier(speed)
	current_score += points_per_pixel * movement
	$GUI/HBoxContainer/ScoreValue.text = str(floor(current_score))


func increase_speed_every(secs: float):
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = secs
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()


func _on_timer_timeout():
	speed = min(speed + 10, MAX_SPEED)
	if has_node("Player"):
		$Player/Sprite/AnimationPlayer.playback_speed += 0.1


func set_godmode(enabled):
	god_mode = enabled
	if has_node("Player"):
		var player = $Player
		if player.has_node("Hitbox"):
			$Player/Hitbox.monitoring = !god_mode
	$GUI/Godmode.visible = enabled


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("godmode_toggle"):
		set_godmode(!god_mode)


func get_points_multiplier(p_speed):
	if p_speed <= 120:
		return 1.0
	if p_speed > 120 and p_speed <= 140:
		return 1.1
	if p_speed > 140 and p_speed <= 180:
		return 1.3
	if p_speed > 180:
		return 1.6


func show_gameover():
	$GUI/SpaceToJump.hide()
	$GameoverScreen/Control.show()
	get_tree().paused = true


func _on_PlayerReference_killed() -> void:
	show_gameover()


func _on_Player_killed() -> void:
	show_gameover()
