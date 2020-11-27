extends KinematicBody2D
class_name PlayerRef

signal killed

const DEFAULT_GRAVITY = 500
const input_buffer_frames = 20 # grace time in frames

export(int, 100, 300) var jump_speed = 200

var velocity = Vector2() # pixels per second
var gravity = DEFAULT_GRAVITY
var should_jump = false
var jump_input_buffered = false
var input_buffer_counter = 0


func _physics_process(delta: float) -> void:
	var jump_dir = Vector2(0, 0)
	should_jump = Input.is_action_just_pressed("jump")

	if is_on_floor():
		if should_jump or (jump_input_buffered and input_buffer_counter < input_buffer_frames):
			$JumpSound.play()
			jump_dir.y = -1
			jump_input_buffered = false
			should_jump = false
		if !$Sprite/AnimationPlayer.is_playing():
			$Sprite/AnimationPlayer.play()
	else:
		process_jump()

	velocity.y += gravity * delta + jump_dir.y * jump_speed
	velocity = move_and_slide(velocity, Vector2.UP, false)

	handle_input_buffer()


func process_jump():
	$Sprite/AnimationPlayer.stop(false)

	gravity = DEFAULT_GRAVITY
	if velocity.y < 0 and should_jump:
		gravity *= 0.65

	if should_jump:
		jump_input_buffered = true
		should_jump = false
		input_buffer_counter = 0


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area is Obstacle:
		emit_signal("killed")
		$KilledSound.play()


func handle_input_buffer():
	if input_buffer_counter >= input_buffer_frames:
		jump_input_buffered = false
	else:
		input_buffer_counter += 1
