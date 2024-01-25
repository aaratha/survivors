extends CharacterBody2D

const MAX_SPEED = 600.0
const ACCELERATION = 200.0
const DECELERATION = 300.0
const K_SPRING = 200.0
const DAMPING = 5.0

var current_speed = 0.0
var deceleration_direction = Vector2()

func _physics_process(delta):
	var mousePos = get_viewport().get_mouse_position()
	var direction_to_mouse = (mousePos - global_position).normalized()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var displacement = mousePos - global_position
		var spring_force = K_SPRING * displacement
		var damping_force = -DAMPING * velocity
		var total_force = spring_force + damping_force
		
		current_speed = min(current_speed + ACCELERATION * delta, MAX_SPEED)
		velocity = direction_to_mouse * current_speed + total_force * delta
		deceleration_direction = direction_to_mouse.normalized()
	else:
		current_speed = max(current_speed - DECELERATION * delta, 0.0)
		velocity = deceleration_direction * current_speed

		if current_speed < 0.1:
			current_speed = 0.0
			velocity = Vector2(0, 0)

	move_and_slide()
