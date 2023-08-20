extends Node

@onready var main_menu_scene = preload("res://menus/main_menu.tscn")
@onready var options_menu_scene = preload("res://menus/options_menu.tscn")
@onready var game_level_scene = preload("res://game_level.tscn")
@onready var level_complete_scene = preload("res://menus/level_complete.tscn")

var game_level_node
var level_complete_node
var current_level:int

var main_menu_node
var options_menu_node

func exit_splash_screen():
	var splash_screen = get_tree().get_root().get_node("SplashScreen")
	get_tree().get_root().remove_child(splash_screen)
	splash_screen.queue_free()
	
	load_main_menu()

func load_main_menu():
	main_menu_node = main_menu_scene.instantiate()
	options_menu_node = options_menu_scene.instantiate() 
	get_tree().get_root().add_child(main_menu_node)
	get_tree().get_root().add_child(options_menu_node)
	options_menu_node.hide()

func start_new_game():
	get_tree().get_root().remove_child(main_menu_node)
	get_tree().get_root().remove_child(options_menu_node)
	main_menu_node.queue_free()
	options_menu_node.queue_free()
	
	game_level_node = game_level_scene.instantiate()
	level_complete_node = level_complete_scene.instantiate() # create this for later
	get_tree().get_root().add_child(game_level_node)
	
	load_level(0)


func load_level(level_number:int):
	game_level_node.load_level(GameData.level_data[level_number])
	current_level = level_number
	game_level_node.begin_level()


func level_complete(level_result:String, trapped:int, saved:int):
	get_tree().get_root().call_deferred("remove_child", game_level_node)
	get_tree().get_root().add_child(level_complete_node)
	
	# work out if this is the final level, if so pass true to the level result
	var final_level = false
	if current_level == GameData.level_data.size()-1:
		final_level = true
	
	level_complete_node.set_level_result(current_level, level_result, final_level, trapped, saved)


func next_level():
	get_tree().get_root().call_deferred("remove_child", level_complete_node)
	get_tree().get_root().add_child(game_level_node)
	
	game_level_node.clear()

func clear_complete():
	load_level(current_level + 1)


func return_to_menu():
	game_level_node.queue_free()
	level_complete_node.queue_free()
	current_level = 0
	load_main_menu()


func open_settings():
	main_menu_node.hide()
	options_menu_node.show()
	options_menu_node.update_menu()

func leave_settings():
	main_menu_node.show()
	options_menu_node.hide()
