extends CharacterBody2D

signal moved(new_cable_position, pos)

enum Orientations { LEFT=0, RIGHT, UP, DOWN }

var orientation:int = Orientations.RIGHT

var grabbed:bool = false
var grabbed_offset:Vector2

func _process(delta):
	# handle mouse release in here rather than input event signal just in case the mouse is outside the
	# area when the button is released
	if Input.is_action_just_released("ui_interact") and grabbed == true:
		grabbed = false

func _physics_process(delta):
	if grabbed == true:
		var current_position = global_position+grabbed_offset
		var mouse_position = get_global_mouse_position()
		
		var distance:float = current_position.distance_to(mouse_position)
		var direction:Vector2 = current_position.direction_to(mouse_position)
		
		var speed:float = distance / delta
		
		velocity = direction * speed
		move_and_slide()
		
		emit_signal("moved", $CablePoint.global_position, get_global_mouse_position()-grabbed_offset)

func set_pin_data(cable_ref, connector_id:int):
	$PinArea.set_pin_data(cable_ref, connector_id)

func set_orientation(new_orientation:int):
	orientation = new_orientation
	match orientation:
		Orientations.LEFT:
			rotation_degrees = 180.0
		
		Orientations.RIGHT:
			rotation_degrees = 0.0
		
		Orientations.UP:
			rotation_degrees = 270.0
		
		Orientations.DOWN:
			rotation_degrees = 90.0


func get_cable_position():
	return $CablePoint.global_position


func _on_connector_area_entered(area):
	pass # Replace with function body.


func _on_connector_area_exited(area):
	pass # Replace with function body.


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed == true:
				grabbed = true
				grabbed_offset = get_local_mouse_position()


func _on_component_detector_area_entered(area):
	var required_orientation:int = area.get_required_orientation()
	set_orientation(required_orientation)
