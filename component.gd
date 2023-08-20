extends StaticBody2D

enum Orientations { LEFT=0, RIGHT, UP, DOWN }
enum ComponentType { BUTTON=0, DOOR, BRIDGE }

var component_id:int
var component_name:String = ""
var component_type:ComponentType

var connections:Array[bool] = [false, false, false, false]

func _ready():
	$RightConnector.area_entered.connect(_on_connector_area_entered.bind($RightLight))
	$RightConnector.area_exited.connect(_on_connector_area_exited.bind($RightLight))
	$LeftConnector.area_entered.connect(_on_connector_area_entered.bind($LeftLight))
	$LeftConnector.area_exited.connect(_on_connector_area_exited.bind($LeftLight))
	$TopConnector.area_entered.connect(_on_connector_area_entered.bind($TopLight))
	$TopConnector.area_exited.connect(_on_connector_area_exited.bind($TopLight))
	$BottomConnector.area_entered.connect(_on_connector_area_entered.bind($BottomLight))
	$BottomConnector.area_exited.connect(_on_connector_area_exited.bind($BottomLight))

func set_component_data(c_id, c_name, c_type, c_num):
	component_id = c_id
	component_name = c_name
	component_type = c_type
	var n = component_name
	if c_num > 0:
		n = "%s %s" % [n, c_num]
	$Label.set_text(n)

func set_connection(slot:int):
	$AnimatedSprite2D.set_frame(1)

func remove_connection(slot:int):
	$AnimatedSprite2D.set_frame(0)


func get_component_type():
	return component_type

func get_connector_join_position(orientation) -> Vector2:
	var join_location:Vector2 = Vector2.ZERO
	
	match orientation:
		Orientations.LEFT:
			join_location = %LeftConnectorJoin.global_position
		Orientations.RIGHT:
			join_location = %RightConnectorJoin.global_position
		Orientations.UP:
			join_location = %TopConnectorJoin.global_position
		Orientations.DOWN:
			join_location = %BottomConnectorJoin.global_position
	
	return join_location

func _on_connector_area_entered(area, light):
	light.set_frame(1)
	
	var pin_data = area.get_pin_data()
	pin_data["cable_ref"].set_connection(pin_data["connector_id"], component_id)

func _on_connector_area_exited(area, light):
	light.set_frame(0)
	
	var pin_data = area.get_pin_data()
	pin_data["cable_ref"].clear_connection(pin_data["connector_id"])
