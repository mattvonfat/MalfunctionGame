extends Node2D

var level_text = { 
			"DEATH": "The infiltrators have been killed! This should significantly delay them!", 
			"BLOCKED": "The infiltrators have been held up. This should buy us some time!", 
			"COMPLETE": "The infiltrators made it through. We're going to need more time if we are going to get everyone out safely." }

func set_level_result(level_number:int, level_result:String, final_level:bool, trapped:int, saved:int):
	if final_level == true:
		%NextLevelButton.hide()
		%MainMenuButton.show()
		var actual_number = level_number+1
		%Label.set_text("Game completed!")
		%Label2.set_text("The infiltrators have now reached us, there's not much more we can do.")
		var left:int = 21-trapped
		if left > 0:
			%Label3.set_text("We managed to evacuate %s of the 21 people who were trapped, but it would have been far fewer without your help!" % left)
		else:
			%Label3.set_text("We managed to evacuate all 21 trapped people, we couldn't have done this without your help!")
	else:
		%NextLevelButton.show()
		%MainMenuButton.hide()
		var actual_number = level_number+1
		%Label.set_text("Level %s completed!" % actual_number)
		%Label2.set_text(level_text[level_result])
		%Label3.set_text("We've managed to evacuate another %s people, but we still have %s trapped!" % [saved, trapped])


func _on_next_level_button_pressed():
	GameManager.next_level()


func _on_main_menu_button_pressed():
	GameManager.return_to_menu()
