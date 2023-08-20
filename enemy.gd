extends CharacterBody2D

const SPEED = 200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var moving:bool = false
var freeze:bool = true

func set_freeze(val:bool):
	freeze = val

func start_movement():
	moving = true

func stop_movement():
	moving = false


func _physics_process(delta):
	if freeze == false:
		# in not frozen enemy falls
		if not is_on_floor():
			velocity.y += gravity * delta
			$Person/AnimationTree/AnimationPlayer.play("fall")
		
		if moving == true:
			if is_on_floor() == true:
				$Person/AnimationTree/AnimationPlayer.play("run")
				var direction = -1
				if direction:
					velocity.x = direction * SPEED
				else:
					velocity.x = move_toward(velocity.x, 0, SPEED)
		else:
			velocity.x = 0
		
		move_and_slide()
