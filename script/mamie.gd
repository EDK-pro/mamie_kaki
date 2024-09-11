extends CharacterBody3D

@export var modele_mamie : MeshInstance3D

var mouse_sensitivity : float = 0.05
var souris_derniere_position = Vector3.ZERO

@export var min_pitch: float = -89.9
@export var max_pitch: float = 50

@export var min_yaw: float = 0
@export var max_yaw: float = 360

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interraction"):
		pass
	
func _process(delta: float) -> void:
	

	bouger_mamie()
	
	move_and_slide()
	
	
	

func bouger_mamie():
	var input_deplacement = Input.get_vector("avancer","reculer","gauche","droite")
	var direction_mamie = Vector3(input_deplacement.y,0,input_deplacement.x).rotated(Vector3.UP,camera.rotation.y)
	if velocity.length() > 0.2:
		var look_direction: Vector2 = Vector2(velocity.z, velocity.x)
		modele_mamie.rotation.y = look_direction.angle()
	velocity = direction_mamie * 2.0
	

func objet_dessus():
	print("COUBEH")
