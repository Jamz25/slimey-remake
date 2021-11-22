extends Node2D

onready var main_menu = $MainMenu
onready var settings_menu = $SettingsMenu
onready var ip_edit = $SettingsMenu/IPEdit

onready var host_menu = $HostingMenu
onready var host_menu_ip_show = $HostingMenu/IPLabel

func _ready():
	get_tree().connect("network_peer_connected", self, "_player_connected")

func _on_Host_button_down():
	print("hosting game")
	var net = NetworkedMultiplayerENet.new()
	net.create_server(56231, 4)
	get_tree().set_network_peer(net)
	main_menu.visible = false
	host_menu.visible = true
	print(IP.get_local_addresses())
	host_menu_ip_show.text = "Your Local IP: " + str(IP.get_local_addresses()[len(IP.get_local_addresses() ) - 1])


func _on_Join_button_down():
	print("joining game")
	var net = NetworkedMultiplayerENet.new()
	net.create_client(ip_edit.text, 56231)
	get_tree().set_network_peer(net)


func _player_connected(id):
	Globals.player2id = id
	var game = preload("res://World/World.tscn").instance()
	get_tree().get_root().add_child(game)
	hide()


func _on_SettingButton_button_down():
	main_menu.visible = false
	settings_menu.visible = true

func _on_BackButton_button_down():
	main_menu.visible = true
	settings_menu.visible = false
