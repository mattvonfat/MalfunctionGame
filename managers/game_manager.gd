extends Node

enum Orientations { LEFT=0, RIGHT, UP, DOWN }
enum CableType { DATA=0, POWER }

var level_data = { 
	"components": ["BUTTON", "DOOR", "BRIDGE"], 
	"cables": [
		{ "type": CableType.DATA, "connections": [{"component" : 1, "pin": 1},{"component": 0, "pin": 3 }] } ] 
	}
