extends Node2D

signal button_activated(body_reference)

func set_number(number:int):
	$Label.set_text("%s" % number)

func _on_area_2d_body_entered(body):
	emit_signal("button_activated", body)
