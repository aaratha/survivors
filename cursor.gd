extends CharacterBody2D
@onready var _animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var mousePos = get_viewport().get_mouse_position()
	self.global_position = mousePos
	_animated_sprite.play("default")
	
