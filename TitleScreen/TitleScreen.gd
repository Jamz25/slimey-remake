extends Node2D

onready var main_menu = $MainMenu
onready var settings_menu = $SettingsMenu

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _on_Host_button_down():
	print("hosting game")
	var net = NetworkedMultiplayerENet.new()
	net.create_server(56231, 4)
	get_tree().set_network_peer(net)


func _on_Join_button_down():
	print("joining game")
	var net = NetworkedMultiplayerENet.new()
	net.create_client("192.168.0.160", 56231)
	get_tree().set_network_peer(net)


func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://World/World.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()


func _on_SettingButton_button_down():
	main_menu.visible = false
	settings_menu.visible = true
