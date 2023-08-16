extends Area2D

enum Orientations { LEFT=0, RIGHT, UP, DOWN }

@export var required_orientation : Orientations

func get_required_orientation() -> int:
	return required_orientation
