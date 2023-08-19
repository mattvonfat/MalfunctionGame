extends Node2D

signal activation_complete(tile_reference)
signal door_reached(door_state:bool)

var door_open:bool = false

func activate() -> void:
	door_open = true
	%DoorAnimationPlayer.play("OpenDoor")

func _on_door_animation_player_animation_finished(anim_name):
	if anim_name == "OpenDoor":
		emit_signal("activation_complete", self)

# Detects when player has reached door and sends a signal saying whether it is closed or open.
func _on_door_area_body_entered(body):
	emit_signal("door_reached", door_open)
