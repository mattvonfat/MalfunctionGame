extends Node

enum Orientations { LEFT=0, RIGHT, UP, DOWN }
enum CableType { DATA=0, POWER }
enum ComponentType { BUTTON=0, DOOR, BRIDGE }
enum RoomTiles { DOOR=0, FLOOR, BRIDGE }
enum RoomItems { BUTTON=0 }

@onready var main_menu_scene = preload("res://menus/main_menu.tscn")

var level_data = { 
	"room_data": {
		"tiles": [RoomTiles.DOOR, RoomTiles.FLOOR, RoomTiles.BRIDGE, RoomTiles.FLOOR],
		"items": [
			{ "id": 100, "type": RoomItems.BUTTON, "position": Vector2(604, 382) }
		]
	},
	"circuit_data": {
		"components": [
			{ "id": 100, "type": ComponentType.BUTTON, "name": "Button", "position": Vector2(889, 160) },
			{ "id": 101, "type": ComponentType.DOOR, "name": "Door", "position": Vector2(209, 150) },
			{ "id": 102, "type": ComponentType.BRIDGE, "name": "Bridge", "position": Vector2(223, 480) },
		], 
		"cables": [
			{ "id": 201, "type": CableType.DATA, "connections": [{"component" : 1, "pin": 1},{"component": 0, "pin": 3 }] } ] 
	} }



func exit_splash_screen():
	var splash_screen = get_tree().get_root().get_node("SplashScreen")
	get_tree().get_root().remove_child(splash_screen)
	splash_screen.queue_free()
	
	load_main_menu()

func load_main_menu():
	var main_menu_node = main_menu_scene.instantiate()
	get_tree().get_root().add_child(main_menu_node)


