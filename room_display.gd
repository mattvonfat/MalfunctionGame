extends Node2D

@onready var tile_scenes:Array = [ 
				preload("res://room tiles/door_tile.tscn"),
				preload("res://room tiles/floor_tile.tscn"),
				preload("res://room tiles/bridge_tile.tscn") 
			]

@onready var item_scenes:Array = [
				preload("res://items/button_item.tscn")
			]

var player_body

func _ready():
	load_room(GameManager.level_data["room_data"])

func load_room(room_data):
	var room_x_offset:int = 0
	
	for room in room_data["tiles"]:
		var new_room = tile_scenes[room].instantiate()
		$RoomTiles.add_child(new_room)
		new_room.position.x = room_x_offset
		room_x_offset += 288
		new_room.activation_complete.connect(_on_activation_complete)
		if room == 0:
			# is a door
			new_room.door_reached.connect(_on_door_reached)
	
	for item in room_data["items"]:
		var new_item = item_scenes[item["type"]].instantiate()
		$RoomItems.add_child(new_item)
		new_item.position = item["position"]
		new_item.button_activated.connect(_on_button_activated.bind(item["id"]))

func _on_area_2d_body_entered(body):
	if body.is_leader() == true:
		player_body = body
		body.stop_movement()
		$RoomTiles.get_node("DoorTile").activate()

func _on_activation_complete(tile_reference):
	player_body.start_movement()

func _on_button_activated(body_reference, button_id:int):
	player_body = body_reference
	$RoomTiles.get_node("DoorTile").activate()

# Function to detect when enemy has fallen to their death. End level.
func _on_death_zone_body_entered(body):
	print("Fallen to death!")

# Enemy has reached door, end level.
func _on_door_reached(door_open:bool):
	if door_open == true:
		print("Enemy got through door.")
	else:
		print("Enemy reach door but it's closed")
