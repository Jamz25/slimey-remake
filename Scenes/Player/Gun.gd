extends Node2D

onready var sprite = $Sprite

const ROTATE_SPEED = 15

func _process(delta):
	if is_network_master():
		rotation = lerp_angle(rotation, rotation + get_angle_to(get_global_mouse_position()), ROTATE_SPEED * delta)
		rotation_degrees = fmod(rotation_degrees, 360.0)
		sprite.flip_v = abs(rotation_degrees) > 90 and abs(rotation_degrees) < 270
