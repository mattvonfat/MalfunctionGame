extends Area2D

var pin_data

func set_pin_data(cable_ref, connector_id:int):
	pin_data = { "cable_ref": cable_ref, "connector_id": connector_id }

func get_pin_data():
	return pin_data
