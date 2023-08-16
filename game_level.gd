extends Node2D

enum Orientations { LEFT=0, RIGHT, UP, DOWN }

@onready var cable_scene = preload("res://cable.tscn")

@onready var cable = $Cable

@onready var comps:Array = [$Component3, $Component, $Component2]

func _ready():
	load_level()

func load_level():
	var level_data = GameManager.level_data
	
	var cable_data = level_data["cables"]
	for cable in cable_data:
		var new_cable = cable_scene.instantiate()
		$Cables.add_child(new_cable)
		
		new_cable.set_type(cable["type"])
		
		var pin_id = 0
		for connection in cable["connections"]:
			var connection_position = comps[connection["component"]].get_connector_join_position(connection["pin"])
			new_cable.set_connector_position(pin_id, connection_position)
			pin_id += 1

func run_level():
	var cable_connections:Array = cable.get_connected_components()
	var connections:Array
	
	for i in cable_connections:
		if i == null:
			connections.append(null)
		else:
			connections.append(i.get_component_type())
	
	if connections.has(null):
		# nothing will happen nothing is connected
		print("No connections.")
	
	elif connections.has("BUTTON"):
		if connections.has("DOOR"):
			# button opnes door so enemies gets through like normal
			print("Door opened.")
		
		elif connections.has("BRIDGE"):
			# button retratcs bridge so enemies die
			print("Bridge retracted.")
		
		else:
			# nothing will happen as button won't be connected to anything
			print("Button not connected.")
	
	else:
		# nothing will happen as button won't be connected to anything
		print("Button not connected.")


func _on_ready_button_pressed():
	run_level()
