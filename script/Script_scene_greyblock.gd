extends Node3D

signal changer_deplacement(rotation_guizmo)

@export var pcam_milieu : PhantomCamera3D
@export var pcam_gauche : PhantomCamera3D
@export var pcam_droite : PhantomCamera3D
@export var cam_proche : PhantomCamera3D
@export var text : Control

@export var mamie : Node3D
var controlleur_mamie : CharacterBody3D

var interactible : Array[Node]
var hitbox_objets : Array[Node3D]

var pcam_tab : Array[PhantomCamera3D] = []

func _ready() -> void:
	pcam_tab = [pcam_milieu,pcam_gauche, pcam_droite,cam_proche]
	controlleur_mamie = mamie.get_node("Controlleur_mamie")
	changer_deplacement.connect(controlleur_mamie.rotate_guizmo.bind())
	interactible = get_tree().get_nodes_in_group("objets_interaction")
	hitbox_objets.resize(interactible.size())
	for i in interactible.size():
		hitbox_objets[i] = interactible[i].get_parent()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interraction"):
		var index = 0
		for i in interactible:
			if i.selected :
				choix_souvenirs(hitbox_objets[index])
			index += 1
	if event.is_action_pressed("fin_dialogue"):
		text.play_anim()
		cam_proche.priority = 0

func _on_droite_body_entered(body: Node3D) -> void:
	changer_camera(pcam_droite)
	changer_deplacement.emit(pcam_droite.rotation.y)


func _on_milieu_body_entered(body: Node3D) -> void:
	changer_camera(pcam_milieu)
	changer_deplacement.emit(pcam_milieu.rotation.y)

func _on_gauche_body_entered(body: Node3D) -> void:
	changer_camera(pcam_gauche)
	changer_deplacement.emit(pcam_gauche.rotation.y)

func changer_camera(camera_voulue : PhantomCamera3D):
	for c in pcam_tab :
		c.priority = 0
		if camera_voulue == c:
			c.priority = 1

func choix_souvenirs(souvenir : Node3D):
	cam_proche.follow_target = souvenir
	cam_proche.position = souvenir.position
	cam_proche.priority = 2
	text.play_anim()
	print(souvenir)
	if str(souvenir).get_slice(":",0) == "table_chaise":
		print("coubeh")
