extends Node2D

signal level_complete(status)

@onready var tile_scenes:Array = [ 
				preload("res://room tiles/door_tile.tscn"),
				preload("res://room tiles/floor_tile.tscn"),
				preload("res://room tiles/bridge_tile.tscn") 
			]

@onready var item_scenes:Array = [
				preload("res://items/button_item.tscn")
			]

@onready var enemy_scene = preload("res://enemies.tscn")


var connection_data

var room_info = {}

var level_end_type = ""
var enemy_node


func load_room(room_data):
	var room_x_offset:int = 0
	
	for room in room_data["tiles"]:
		var new_room = tile_scenes[room["type"]].instantiate()
		$RoomTiles.add_child(new_room)
		new_room.name = "%s" % room["id"]
		new_room.position.x = room_x_offset
		room_x_offset += 288
		new_room.activation_complete.connect(_on_activation_complete)
		if room["type"] == 0:
			# is a door
			new_room.door_reached.connect(_on_door_reached)
	
	for item in room_data["items"]:
		var new_item = item_scenes[item["type"]].instantiate()
		$RoomItems.add_child(new_item)
		new_item.position = item["position"]
		new_item.button_activated.connect(_on_button_activated.bind(item["id"]))
		new_item.set_number(item["num"])


func set_connection_data(data):
	connection_data = data


func run_room():
	enemy_node = enemy_scene.instantiate()
	$Enemies.add_child(enemy_node)
	enemy_node.global_position = $EnemyMarker.global_position
	enemy_node.set_freeze(false)
	enemy_node.start_movement()


func _on_activation_complete(tile_reference):
	enemy_node.start_movement()


func _on_button_activated(body_reference, button_id:int):
	enemy_node.stop_movement()
	var activation = false
	
	for connections in connection_data:
		var index = connections.find(button_id)
		if index != -1:
			var component_index = 1 - index
			var component_id = connections[component_index]
			if component_id != null:
				var component_tile = $RoomTiles.get_node("%s" % component_id)
				component_tile.activate()
				activation = true
	
	if activation == false:
		# want a slight delay before player starts moving if the button doesn't do anything
		$WaitTimer.start()


# Function to detect when enemy has fallen to their death. End level.
func _on_death_zone_body_entered(body):
	level_end_type = "DEATH"
	$LevelEndTimer.start()

# Enemy has reached door, end level.
func _on_door_reached(door_open:bool):
	if door_open == true:
		level_end_type = "COMPLETE"
	else:
		level_end_type = "BLOCKED"
	$LevelEndTimer.start()


func _on_wait_timer_timeout():
	enemy_node.start_movement()



func clear():
	for node in $RoomTiles.get_children():
		$RoomTiles.remove_child(node)
		node.queue_free()
	
	for node in $RoomItems.get_children():
		$RoomItems.remove_child(node)
		node.queue_free()


func _on_level_end_timer_timeout():
	emit_signal("level_complete", level_end_type)
	enemy_node.stop_movement()
	enemy_node.set_freeze(true)
	enemy_node.global_position = Vector2(1000.0, 0.0)
	enemy_node.hide_enemies()
	level_end_type = ""
	enemy_node.queue_free()
