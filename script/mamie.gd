extends CharacterBody3D

@export var bras_camera : SpringArm3D
var souris_derniere_position = Vector3.ZERO

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion :
		print(event)
		bras_camera.rotate_x(event.relative.y * 0.001)
		bras_camera.rotate_y(event.relative.x * 0.001)
		bras_camera.rotation.z = 0.0
	
func _process(delta: float) -> void:
	bouger_mamie()
	move_and_slide()
	bras_camera.position = position
	
	
	

func bouger_mamie():
	var input_deplacement = Input.get_vector("avancer","reculer","gauche","droite")
	var direction_mamie = Vector3(input_deplacement.y,0,input_deplacement.x).rotated(Vector3.UP,bras_camera.rotation.y)
	velocity = direction_mamie * 2.0
