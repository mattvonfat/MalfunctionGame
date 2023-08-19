extends Node2D

signal activation_complete(tile_reference)

var bridge_down:bool = false

func activate() -> void:
	bridge_down = true
	%BridgeAnimationPlayer.play("bridge_down")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "bridge_down":
		emit_signal("activation_complete", self)
