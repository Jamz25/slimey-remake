extends KinematicBody2D

const SPEED = 300
const CAM_SPEED = 2

var velocity = Vector2()

onready var anim_tree = $AnimationTree
onready var camera = $Camera2D
onready var sprite = $Sprite
onready var gun = $Gun
onready var gun_sprite = gun.get_node("Sprite")

func _ready():
	camera.set_as_toplevel(true)
	if is_network_master():
		camera.current = true

remote func _update_position(pos):
	global_position = pos

remote func _update_gun(gun_dir, gun_flip):
	gun.rotation_degrees = gun_dir
	gun_sprite.flip_v = gun_flip

remote func _update_anim(anim_blend_pos):
	anim_tree.set("parameters/blend_position", anim_blend_pos)

func _update_peers():
	rpc_unreliable("_update_position", global_position)
	rpc_unreliable("_update_gun", gun.rotation_degrees, gun_sprite.flip_v)
	rpc_unreliable("_update_anim", anim_tree.get("parameters/blend_position"))

func _process(delta):
	if is_network_master():
		#camera.global_position = lerp(camera.global_position, global_position, CAM_SPEED * delta)
		var input_vector = Vector2()
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		if input_vector.x != 0:
			anim_tree.set("parameters/blend_position", input_vector.x)
		velocity = input_vector.normalized() * SPEED
		velocity = move_and_slide(velocity)
		_update_peers()
	camera.global_position = lerp(camera.global_position, global_position, CAM_SPEED * delta)
