extends Node2D

enum CableType { DATA, POWER }
enum Orientations { LEFT=0, RIGHT, UP, DOWN }

@onready var connectors:Array = [$Connector1, $Connector2]

var cable_type

var connected_components:Array = [null,null]

func _ready():
	$Connector1.set_orientation(Orientations.LEFT)
	$Connector1.set_pin_data(self, 0)
	$Connector2.set_pin_data(self, 1)
	# set the initial position for the cord line
	$CordLine.set_point_position(0, to_local($Connector1.get_cable_position()))
	$CordLine.set_point_position(1, to_local($Connector2.get_cable_position()))

func set_type(type:int):
	cable_type = type

func set_connector_position(pin_id:int, new_pos:Vector2, p:int):
	if p == 1:
		connectors[pin_id].set_orientation(Orientations.LEFT)
	elif p == 3:
		connectors[pin_id].set_orientation(Orientations.UP)
	connectors[pin_id].global_position = new_pos
	$CordLine.set_point_position(pin_id, to_local(connectors[pin_id].get_cable_position()))

func set_connection(connector_id:int, component_id:int):
	connected_components[connector_id] = component_id

func clear_connection(connector_id:int):
	connected_components[connector_id] = null

func get_connected_components() -> Array:
	return connected_components

func _on_connector_1_moved(new_cable_position, pos):
	$CordLine.set_point_position(0, to_local(new_cable_position))
	#$Connector1.position = to_local(pos)

func _on_connector_2_moved(new_cable_position, pos):
	$CordLine.set_point_position(1, to_local(new_cable_position))
	#$Connector2.position = to_local(pos)
