extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _sprite = $Sprite2D

const k = 500

var current_speed = 0.0
var deceleration_direction = Vector2()
var a = 0.0
var b = 40
var V = 0.0
var m = 10



func _physics_process(delta):
	var mousePos = get_viewport().get_mouse_position()
	var direction_to_mouse = (mousePos - global_position).normalized()
	var character_position = self.global_position
	var distance_to_mouse = mousePos.distance_to(character_position)
	var boundary = 80 * direction_to_mouse
	var delta_x = -boundary + mousePos - global_position
	V = velocity
	
	var cursor = get_node("%cursor")
	var cursor_velocity = cursor.velocity.length()
	
	_sprite.rotation = deg_to_rad(135)
	
	_animated_sprite.flip_h = mousePos.x < character_position.x
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		b = 40 - 0.7 * cursor_velocity
		a = (-b*V + k*delta_x)/m
		velocity += a * delta
		_animated_sprite.play("move")

	else:
		a = b*V.length()/m
		velocity = V - V.normalized() * a * delta
		_animated_sprite.play("default")
	look_at(get_global_mouse_position())
	move_and_slide()
