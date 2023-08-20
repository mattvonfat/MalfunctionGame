extends Node2D

signal round_ended()

enum Orientations { LEFT=0, RIGHT, UP, DOWN }

@onready var component_scene = preload("res://component.tscn")
@onready var cable_scene = preload("res://cable.tscn")




func add_component(component_data):
	var new_component = component_scene.instantiate()
	$ComponentContainer.add_child(new_component)
	new_component.global_position = component_data["position"]+Vector2(0.0, 768.0)
	new_component.set_component_data(component_data["id"], component_data["name"], component_data["type"], component_data["num"])
	
	return new_component


func add_cable(cable_data):
	var new_cable = cable_scene.instantiate()
	$CableContainer.add_child(new_cable)
	
	new_cable.set_type(cable_data["type"])
	
	return new_cable


func get_cables():
	return $CableContainer.get_children()




func clear():
	for node in $CableContainer.get_children():
		$CableContainer.remove_child(node)
		node.queue_free()
	
	for node in $ComponentContainer.get_children():
		$ComponentContainer.remove_child(node)
		node.queue_free()
