extends Control


func _on_new_game_pressed():
	GameManager.start_new_game()


func _on_settings_pressed():
	GameManager.open_settings()
