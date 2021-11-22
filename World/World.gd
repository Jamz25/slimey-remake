extends Node2D

onready var players = $Players
onready var playerSpawn = $PlayerSpawn

func _ready():
	# instantiate players
	var player1 = preload("res://Scenes/Player/Player.tscn").instance()
	player1.set_name(str(get_tree().get_network_unique_id()))
	player1.set_network_master(get_tree().get_network_unique_id())
	player1.global_position = playerSpawn.position
	player1.scale = Vector2(6, 6)
	players.add_child(player1)
	
	var player2 = preload("res://Scenes/Player/Player.tscn").instance()
	player2.set_name(str(Globals.player2id))
	player2.set_network_master(Globals.player2id)
	player2.global_position = playerSpawn.position
	player2.scale = Vector2(6, 6)
	players.add_child(player2)
