extends Node2D

var snapped:bool = false

func _ready():
	# set the initial position of the base of the lines
	%Line1.set_point_position(0, %BaseMarker1.global_position)
	%Line2.set_point_position(0, %BaseMarker2.global_position)
	# start the animation
	$AnimationPlayer.play("intro")


func _process(delta):
	# Update lines - only update the second hoop if the cord hasn't snapped yet
	%Line1.set_point_position(1, %HoopMarker1.global_position)
	if snapped == false:
		%Line2.set_point_position(1, %HoopMarker2.global_position)
	
	# let the user exit with escape
	if Input.is_action_just_pressed("escape"):
		GameManager.exit_splash_screen()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "intro":
		# cord snaps at this point so need to update the variable to stop the position being updated
		$AnimationPlayer.play("intro_2")
		snapped = true
	
	else:
		# finish the splash screen anuimation so exit
		GameManager.exit_splash_screen()
