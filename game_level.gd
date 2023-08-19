extends Node2D

enum Orientations { LEFT=0, RIGHT, UP, DOWN }

@onready var component_scene = preload("res://component.tscn")
@onready var cable_scene = preload("res://cable.tscn")

@onready var cable_container = %CableContainer
@onready var component_container = %ComponentContainer

@onready var comps:Array = []

func _ready():
	load_level()
	$Room.hide()
	$Room.level_complete.connect(_on_level_complete)
	$Room.button_pressed.connect(_on_button_pressed)

func load_level():
	var level_data = GameManager.level_data["circuit_data"]
	
	var component_data = level_data["components"]
	for component in component_data:
		var new_component = component_scene.instantiate()
		component_container.add_child(new_component)
		new_component.global_position = component["position"]
		new_component.set_component_data(component["name"], component["type"])
		comps.append(new_component)
	
	var cable_data = level_data["cables"]
	for cable in cable_data:
		var new_cable = cable_scene.instantiate()
		cable_container.add_child(new_cable)
		
		new_cable.set_type(cable["type"])
		
		var pin_id = 0
		for connection in cable["connections"]:
			var connection_position = comps[connection["component"]].get_connector_join_position(connection["pin"])
			new_cable.set_connector_position(pin_id, connection_position)
			pin_id += 1

func run_level():
	$Room.show()
	$Room/CharacterBody2D.start_movement()
#	var cables = cable_container.get_children()
#	var cable_connections:Array = cables.get_connected_components()
#	var connections:Array
#
#	for i in cable_connections:
#		if i == null:
#			connections.append(null)
#		else:
#			connections.append(i.get_component_type())
#
#	if connections.has(null):
#		# nothing will happen nothing is connected
#		print("No connections.")
#
#	elif connections.has("BUTTON"):
#		if connections.has("DOOR"):
#			# button opnes door so enemies gets through like normal
#			print("Door opened.")
#
#		elif connections.has("BRIDGE"):
#			# button retratcs bridge so enemies die
#			print("Bridge retracted.")
#
#		else:
#			# nothing will happen as button won't be connected to anything
#			print("Button not connected.")
#
#	else:
#		# nothing will happen as button won't be connected to anything
#		print("Button not connected.")


func _on_ready_button_pressed():
	run_level()

func _on_level_complete(result:String):
	match result:
		"DOOR":
			print("Door reached.")
		
		"FALL":
			print("Enemy fell to their death.")

func _on_button_pressed(button_id:int):
	pass
