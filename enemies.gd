extends Node2D

var moving:bool = false
var frozen:bool = true

func _ready():
	$Leader/Person/AnimationTree/AnimationPlayer.animation_finished.connect(_on_animation_finished.bind($Leader/Person/AnimationTree/AnimationPlayer))
	$Follower1/Person/AnimationTree/AnimationPlayer.animation_finished.connect(_on_animation_finished.bind($Follower1/Person/AnimationTree/AnimationPlayer))
	$Follower2/Person/AnimationTree/AnimationPlayer.animation_finished.connect(_on_animation_finished.bind($Follower2/Person/AnimationTree/AnimationPlayer))

func set_freeze(val:bool):
	$Leader.set_freeze(val)
	$Follower1.set_freeze(val)
	$Follower2.set_freeze(val)

func start_movement():
	moving = true
	$Leader.start_movement()
	$Follower1.start_movement()
	$Follower2.start_movement()
	$Leader/Person/AnimationTree/AnimationPlayer.play("run")
	$Follower1/Person/AnimationTree/AnimationPlayer.play("run")
	$Follower2/Person/AnimationTree/AnimationPlayer.play("run")

func stop_movement():
	moving = false
	$Leader.stop_movement()
	$Follower1.stop_movement()
	$Follower2.stop_movement()
	$Leader/Person/AnimationTree/AnimationPlayer.pause()
	$Follower1/Person/AnimationTree/AnimationPlayer.pause()
	$Follower2/Person/AnimationTree/AnimationPlayer.pause()


func hide_enemies():
	$Leader.hide()
	$Follower1.hide()
	$Follower2.hide()
	$Leader.global_position = Vector2(1000.0, 1000.0)
	$Follower1.global_position = Vector2(1000.0, 1000.0)
	$Follower2.global_position = Vector2(1000.0, 1000.0)

func _on_animation_finished(animation_node):
	animation_node.play("run")
