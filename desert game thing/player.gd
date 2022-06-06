extends KinematicBody

#physics

var MOVEMENT_SPEED : float = 12
var JUMPFORCE : float = 12
var GRAVITY : float = 15


#cam look

var minLookangle : float = -180.0
var maxLookAngle : float = 0.0
var lookSens : float = 15

#vectors

var vel : Vector3 = Vector3()
var fall : Vector3 =Vector3()
var mouseDelta : Vector2 = Vector2()
var velxz : Vector2 = Vector2()

#components

onready var camera : Camera = get_node("CollisionShape/Camera")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$AudioStreamPlayer.play(0)


 
func _physics_process(delta):
	
	#reset x and z vel
	vel.x = 0
	vel.z = 0
	
	var input = Vector2()
	

	#movement inputs
	
	if Input.is_action_pressed("move_forward"):
		input.y -= 1 	
	if Input.is_action_pressed("move_backward"):
		input.y += 1 
	if Input.is_action_pressed("move_right"):
		input.x += 1 
	if Input.is_action_pressed("move_left"):
		input.x -= 1 
	if Input.is_action_pressed("veryfast"):
		MOVEMENT_SPEED = 120
	if Input.is_action_just_released("veryfast"):
		MOVEMENT_SPEED = 12

	input = input.normalized()
	
	#get forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward*input.y + right*input.x)
	
	#set velocity
	vel.x = relativeDir.x * MOVEMENT_SPEED
	vel.z = relativeDir.z * MOVEMENT_SPEED 
	


	#apply gravity
	if $RayCast.is_colliding():
		vel.y -= 10 * GRAVITY * delta
	else:
		vel.y -= GRAVITY * delta

	
	
	velxz.x = vel.x
	velxz.y = vel.z
	
	#var floor_normal = $RayCast.get_collision_normal()
	var floor_normal = get_floor_normal() 
	#move the player
	vel = move_and_slide_with_snap(vel, -floor_normal , Vector3.UP, true,4,0.8)



	#jump
	if is_on_floor():
		if Input.is_action_pressed("jump"):
			vel = move_and_slide_with_snap(vel, Vector3(0,0,0), Vector3.UP, true,4,0.8)		
			vel.y = JUMPFORCE
			$jumpsound.play()
			


			
	if velxz.length() > 10:
		if $RayCast.is_colliding():
			if $Timer.time_left <= 0:
				$footsteps.pitch_scale = rand_range(1,1.1)
				$footsteps.play()
				$Timer.start(0.4)
		else:
			$footsteps.stop()
	else:
		$footsteps.stop()
		





func _process(delta):

	#rotate camera along x axis
	camera.rotation_degrees.x -= mouseDelta.y * lookSens * delta
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x,minLookangle,maxLookAngle)
	#rotate player along y axis
	rotation_degrees.y -= mouseDelta.x * lookSens * delta 
	#reset
	mouseDelta = Vector2()

func _input(event):

	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	

	
	
	


func _on_SpinBox_value_changed(SENSITIVITY):
	lookSens = SENSITIVITY


func _on_SpinBox2_value_changed(value):
	var db : float
	if value == 0:
		db = -80
	else:
		db = 0.3*value-30
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),db)



