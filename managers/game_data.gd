extends Node

enum Orientations { LEFT=0, RIGHT, UP, DOWN }
enum CableType { DATA=0, POWER }
enum ComponentType { BUTTON=0, DOOR, BRIDGE }
enum RoomTiles { DOOR=0, FLOOR, BRIDGE }
enum RoomItems { BUTTON=0 }

var level_data = [
	
	{ 
	"room_data": {
		"tiles": [
			{ "id": 102, "type": RoomTiles.DOOR }, 
			{ "id": 100, "type": RoomTiles.FLOOR },
			{ "id": 100, "type": RoomTiles.FLOOR },
			{ "id": 100, "type": RoomTiles.FLOOR }],
		"items": [
			{ "id": 101, "type": RoomItems.BUTTON, "num": 1, "position": Vector2(604, 423) }],
		"starting_text": "We're going to start the evacuation process. It looks like they will be making their entry through room 1 so try and hold them off as long as possible."
	},
	"circuit_data": {
		"components": [
			{ "id": 101, "type": ComponentType.BUTTON, "name": "Button", "num": 1, "position": Vector2(889, 260) },
			{ "id": 102, "type": ComponentType.DOOR, "name": "Door", "num": 0, "position": Vector2(209, 250) },
		], 
		"cables": [
			{ "id": 201, "type": CableType.DATA, "connections": [{"component" : 102, "pin": 1},{"component": 101, "pin": 3 }] } ],
		"hint_text": "By disconnecting components from buttons you can delay the infiltrators.",
		"time_limit": 60
	} },
	
	{ 
	"room_data": {
		"tiles": [
			{ "id": 102, "type": RoomTiles.DOOR }, 
			{ "id": 103, "type": RoomTiles.BRIDGE },
			{ "id": 100, "type": RoomTiles.FLOOR },
			{ "id": 100, "type": RoomTiles.FLOOR }],
		"items": [
			{ "id": 101, "type": RoomItems.BUTTON, "num": 1, "position": Vector2(604, 423) }],
			"starting_text": "It looks like they are heading to room 2, we're still going to need more time so try and hold them up as best you can."
	},
	"circuit_data": {
		"components": [
			{ "id": 101, "type": ComponentType.BUTTON, "name": "Button", "num": 1, "position": Vector2(889, 260) },
			{ "id": 102, "type": ComponentType.DOOR, "name": "Door", "num": 0, "position": Vector2(209, 250) },
			{ "id": 103, "type": ComponentType.BRIDGE, "name": "Bridge", "num": 0, "position": Vector2(223, 480) },
		], 
		"cables": [
			{ "id": 201, "type": CableType.DATA, "connections": [{"component" : 102, "pin": 1},{"component": 101, "pin": 3 }] } ] ,
		"hint_text": "Buttons can be connected to different components to cause them to be activated, some of which can kill infiltrators.",
		"time_limit": 60
	} },
	
	{ 
	"room_data": {
		"tiles": [
			{ "id": 102, "type": RoomTiles.DOOR }, 
			{ "id": 100, "type": RoomTiles.FLOOR },
			{ "id": 103, "type": RoomTiles.BRIDGE },
			{ "id": 100, "type": RoomTiles.FLOOR }],
		"items": [
			{ "id": 101, "type": RoomItems.BUTTON, "num": 1, "position": Vector2(926, 423) },
			{ "id": 104, "type": RoomItems.BUTTON, "num": 2, "position": Vector2(365, 423) }],
			"starting_text": "It looks like they are on their way to room 3, we're still going to need more time so try and hold them up as best you can."
	},
	"circuit_data": {
		"components": [
			{ "id": 101, "type": ComponentType.BUTTON, "name": "Button", "num": 1, "position": Vector2(889, 260) },
			{ "id": 104, "type": ComponentType.BUTTON, "name": "Button", "num": 2, "position": Vector2(889, 490) },
			{ "id": 102, "type": ComponentType.DOOR, "name": "Door", "num": 0, "position": Vector2(209, 250) },
			{ "id": 103, "type": ComponentType.BRIDGE, "name": "Bridge", "num": 0, "position": Vector2(223, 500) },
		], 
		"cables": [
			{ "id": 201, "type": CableType.DATA, "connections": [{"component" : 102, "pin": 3},{"component": 101, "pin": 1 }] },
			{ "id": 202, "type": CableType.DATA, "connections": [{"component" : 103, "pin": 3},{"component": 104, "pin": 1 }] } ] ,
		"hint_text": "",
		"time_limit": 60
	} }]
