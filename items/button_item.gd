extends Node2D

signal button_activated(body_reference)

func _on_area_2d_body_entered(body):
	if body.is_leader() == true:
		body.stop_movement()
		emit_signal("button_activated", body)
