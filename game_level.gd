extends Node2D

var component_info = {}

var remaining_time:int

var room_text:String = ""
var circuit_hint_text:String = ""

var waiting_input:bool = false

var total_colleagues:int = 21
var saved_colleagues:int = 0

func _ready():
	$RoomDisplay.level_complete.connect(_on_level_completed)
	%CircuitHintContainer.hide()
	%CircuitTimeContainer.hide()
	
	var events = InputMap.action_get_events("skip_dialog")
	var event = events[0]
	
	if event is InputEventKey:
		var keycode = event.physical_keycode
		var key_text = OS.get_keycode_string(keycode)
		%ConvoContinueLabel.set_text("<%s>" % key_text)


func _process(delta):
	if Input.is_action_just_pressed("skip_dialog"):
		if waiting_input == true:
			waiting_input = false
			$PauseTimer.start()
			%RoomTextContainer.hide()

func load_level(level_data):
	var circuit_data = level_data["circuit_data"]
	
	var component_data = circuit_data["components"]
	for component in component_data:
		var new_component = $CircuitDisplay.add_component(component)
		component_info[component["id"]] = new_component
	
	var cable_data = circuit_data["cables"]
	for cable in cable_data:
		var new_cable = $CircuitDisplay.add_cable(cable)
		# set up the initial positions of the cable connectors
		var pin_id = 0
		for connection in cable["connections"]:
			var connection_position = component_info[connection["component"]].get_connector_join_position(connection["pin"])
			new_cable.set_connector_position(pin_id, connection_position, connection["pin"])
			pin_id += 1
	
	$RoomDisplay.load_room(level_data["room_data"])
	
	room_text = level_data["room_data"]["starting_text"]
	circuit_hint_text = level_data["circuit_data"]["hint_text"]


func begin_level():
	show_room_gui()
	%RoomTextLabel.set_text(room_text)
	waiting_input = true

func on_circuit_round_ended():
	room_transition()

func room_transition():
	$AnimationPlayer.play("room_transition_up")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "room_transition_up":
		run_level()
		
	elif anim_name == "room_transition_down":
		begin_round(100)
		
	
	elif anim_name == "RESET":
		component_info = {}
		$CircuitDisplay.clear()
		$RoomDisplay.clear()
		GameManager.clear_complete()


func begin_round(round_time):
	show_circuit_gui()
	%HintTextLabel.set_text(circuit_hint_text)
	if circuit_hint_text == "":
		%CircuitHintContainer.hide()
	remaining_time = round_time
	%RemainingTimeLabel.set_text("%s s" % remaining_time)
	$RoundTimer.start()

func run_level():
	var connection_data = []
	
	var cables = $CircuitDisplay.get_cables()
	
	for cable in cables:
		var cable_connections:Array = cable.get_connected_components()
		if cable_connections.has(null):
			# if it has a null value then it's not connected
			pass
		else:
			connection_data.append(cable_connections)
	
	$RoomDisplay.set_connection_data(connection_data)
	$RoomDisplay.run_room()


func show_circuit_gui():
	%CircuitHintContainer.show()
	%CircuitTimeContainer.show()
	%RoomTextContainer.hide()

func show_room_gui():
	%CircuitHintContainer.hide()
	%CircuitTimeContainer.hide()
	%RoomTextContainer.show()

func _on_level_completed(status:String):
	var new_saved:int = 2
	match status:
		"DEATH":
			new_saved = 8
		"BLOCKED":
			new_saved = 5
	
	saved_colleagues += new_saved
	
	GameManager.level_complete(status, total_colleagues-saved_colleagues, new_saved)


func clear():
	$AnimationPlayer.play("RESET")


func _on_round_timer_timeout():
	remaining_time -= 1
	if remaining_time <= 0:
		$RoundTimer.stop()
		on_circuit_round_ended()
		%CircuitHintContainer.hide()
		%CircuitTimeContainer.hide()
	else:
		%RemainingTimeLabel.set_text("%s s" % remaining_time)

func _on_ready_button_pressed():
	$RoundTimer.stop()
	%CircuitHintContainer.hide()
	%CircuitTimeContainer.hide()
	on_circuit_round_ended()


func _on_pause_timer_timeout():
	$AnimationPlayer.play("room_transition_down")
