extends CharacterBody3D

@export var modele_mamie : MeshInstance3D
@export var guizmo_forward : MeshInstance3D
@export var guizmo_side : MeshInstance3D
@export var guizmo : Node3D
var mouse_sensitivity : float = 0.05
var souris_derniere_position = Vector3.ZERO

@export var min_pitch: float = -89.9
@export var max_pitch: float = 50

@export var min_yaw: float = 0
@export var max_yaw: float = 360

@export var animation:AnimationPlayer
@export var sound : AudioStreamPlayer3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	pass
	
func _process(delta: float) -> void:
	

	bouger_mamie()
	
	move_and_slide()
	
	if velocity != Vector3.ZERO:
		animation.play("rigAction_001")
		sound.play()
	else :
		sound.stop()
		animation.stop()
	
	

func bouger_mamie():
	var input_deplacement = Input.get_vector("avancer","reculer","gauche","droite")
	var direction_mamie_x = input_deplacement.x * Vector3(guizmo_forward.global_position.x, 0.0, guizmo_forward.global_position.z) 
	var direction_mamie_z = input_deplacement.y * Vector3(guizmo_side.global_position.x, 0.0, guizmo_side.global_position.z)
	var direction_mamie = direction_mamie_x + direction_mamie_z
	#var direction_mamie = Vector3(input_deplacement.y,0,input_deplacement.x).rotated(Vector3.UP,guizmo_forward.rotation.y)
	if velocity.length() > 0.2:
		var look_direction: Vector2 = Vector2(velocity.z, velocity.x)
		modele_mamie.rotation.y = look_direction.angle()
	velocity = direction_mamie * 1.0
	
func rotate_guizmo(rotation_y_voulue : float):
	guizmo.rotation.y = rotation_y_voulue
	

func objet_dessus():
	print("COUBEH")
