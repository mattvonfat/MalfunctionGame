extends Node2D

signal level_complete(result)
signal button_pressed(button_id)

var inputs:Array
var outputs:Array

var door_open:bool = false

# enemy reached door
func _on_door_area_body_entered(body):
	emit_signal("level_complete", "DOOR")


func _on_fall_area_body_entered(body):
	emit_signal("level_complete", "FALL")



func _on_button_area_body_entered(body):
	if body.is_leader() == true:
		body.stop_movement()
		emit_signal("button_pressed", 0)
		door_open = true
		body.start_movement()
