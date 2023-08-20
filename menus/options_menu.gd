extends Control

var wait_key:bool = false

func _ready():
	%NewKeyPanel.hide()

func update_menu():
	var events = InputMap.action_get_events("skip_dialog")
	var event = events[0]
	
	if event is InputEventKey:
		var keycode = event.physical_keycode
		var key_text = OS.get_keycode_string(keycode)
		%ConvoSkipLabel.set_text("%s" % key_text)


func _input(event):
	if wait_key == true:
		if event is InputEventKey:
			var keycode = event.physical_keycode
			var key_text = OS.get_keycode_string(keycode)
			%ConvoSkipLabel.set_text("%s" % key_text)
			%NewKeyPanel.hide()
			InputMap.action_erase_events("skip_dialog")
			InputMap.action_add_event("skip_dialog", event)

func _on_convo_skip_button_pressed():
	wait_key = true
	%NewKeyPanel.show()


func _on_button_pressed():
	GameManager.leave_settings()
