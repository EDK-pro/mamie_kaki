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


var masque : int = 0
var confiture : int = 0
var roues : int = 0
var livre : int = 0
var barbie : int  = 0
var tele : int = 0

func _ready() -> void:
	pcam_tab = [pcam_milieu,pcam_gauche, pcam_droite,cam_proche]
	controlleur_mamie = mamie.get_node("Controlleur_mamie")
	changer_deplacement.connect(controlleur_mamie.rotate_guizmo.bind())
	interactible = get_tree().get_nodes_in_group("objets_interaction")
	hitbox_objets.resize(interactible.size())
	for i in interactible.size():
		hitbox_objets[i] = interactible[i].get_parent()
	print(hitbox_objets)

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
		barbie = false
		tele = false
		livre = false
		
	if event.is_action_pressed("suite_dialogue"):
		if tele != 0:
			match tele:
				1:
					text.texte.text = "La fille : Alors, j’ai entendu que Papa allait amener la télé à la décharge vu qu’elle ne marche pas puis en racheter une autre et Mama voulait la garder. Donc j’ai pensée que en la repeignant, ont peu en faire un meuble ou on pose la nouvelle télé au dessus de la grosse. Comme ça on la jette pas et ont s’en sert pour la nouvelle télé."
				2:
					text.texte.text = "Papie : Ben, j’ai pas dit que j’allai la jeter, j’ai dit que j’allait l'emmener à la décharge, je connais quelqu’un qui voulait la réparer."
				3:
					text.texte.text = "Mamie : (rigole) au moins c’est très jolie comme ça"
				_:
					text.texte.text =  " "
			tele += 1
			if tele == 4 :
				tele = 0
				text.texte.text = " "
		if confiture != 0:
			$"Voix off Confiture".play()
			match confiture:
				1:
					text.texte.text = "Mamie : Il reste du café ? je prend la confiture"
				2:
					text.texte.text = "Papie : tiens (touse)"
				3:
					text.texte.text = "Mamie : Notre fils à appelé, apparemment ce sera une petite fille"
				4:
					text.texte.text = "Papie : Vraiment ? (tousse)"
				5:
					text.texte.text = "Mamie : En pleine forme, elle plus elle à déjà une dent, tu te rend compte"
				6:
					text.texte.text = "Papie : (tousse) (tousse) ils sont heureux ?"
				7:
					text.texte.text = "Mamie : Mais bien sur qu’ils sont heureux, ils sont très bien nos deux enfants. . . tu vas bien ?"
				8:
					text.texte.text = "Papie : (tousse) (tousse) (tousse)"
				_:
					text.texte.text = " "
			confiture += 1
			if confiture == 9:
				confiture = 0
				text.texte.text = " "
				$"glass put down".play()
				$Kaki_3.visible = false
				$Kaki_4.visible = true
		if barbie != 0:
			match barbie:
				1:
					text.texte.text = "Petite fille : Regarde, regarde, regarde !"
				2:
					text.texte.text = "Fille : Mais qu’es que tu à trouvée ?"
				3:
					text.texte.text = "Mamie : Oh mais c’était ta poupée, princesse PQ, tu l’avais fait à partir de ce que tu trouvais dans les toilettes."
				4:
					text.texte.text = "Fille : aaahh oui !! es qu’elle a encore du papier dessus ?"
				5:
					text.texte.text = "Mamie : Ah non je l’ai retirée, il prenait l’humidité"
				6:
					text.texte.text = "Fille : Mon frère va pas apprécier si il apprend qu’elle à joué avec cette poupée"
				_:
					text.texte.text = " "
			barbie += 1
			if barbie == 7 :
				barbie = 0
				text.texte.text = " "
				$Kaki_5.visible = false
				$Kaki_6.visible = true
		if masque != 0:
			match masque:
				1:
					text.texte.text = "Mamie : Tada ."
				2:
					text.texte.text = "Fils : Mais c’est quoi ?"
				3:
					text.texte.text = "Mamie : Ben des masques, je les ai fait avec ton père qui m’à aidée."
				4:
					text.texte.text = "Papie : Comme ça tu pourras aller travailler tranquillement au bureau, vu qu’on trouve plus de masques en magasin."
				5:
					text.texte.text = "Fils : Ma boîte m’a déjà donné des masques, j’en ais déjà plus de cinquante chez moi tout neuf"
				6:
					text.texte.text = "Mamie : Ah . . . alors ont pourait les donner à ta soeur (rigole) elle à déjà l’autre moitié."
				_:
					text.texte.text = ""
			masque += 1
			if masque == 7:
				masque = 0
				text.texte.text = " "
				$Kaki_1.visible = false
				$Kaki_2.visible = true
		if roues != 0:
			match roues:
				1:
					text.texte.text = "Papie : Alors, j’ai changées les roues, essayés de renforcer les fourches, ajouter une sonnette, retaper les frein . . .mais j’ai peur qu’il manque un truc"
				2:
					text.texte.text = "Mamie : Qu’est ce qu’il manque ?"
				3:
					text.texte.text = "Papie : Une pilote . . . qui aime rouler de longue heur sur les sentiers, qui n’à pas froid aux yeux"
				4:
					text.texte.text = "Mamie : Oh toi, grand charmeur. "
				_:
					text.texte.text =  ""
			roues += 1
			if roues == 5:
				roues = 0
				text.texte.text = " "
				$Kaki_6.visible = false
				$Kaki_7.visible = true
				$"Cat purr".play()
		if livre != 0 :
			match livre:
				1:
					text.texte.text = "Petite fille : Bon mamie, où est ce qu'on va ce soir ?"
				2:
					text.texte.text = "Mamie : Y a Jeanne la conteuse qui vient au village cette semaine ! Allez viens tu vas voir comme elle est douée"
				3:
					text.texte.text = "Petite fille : Mamie, j'ai 20 ans tu sais..."
				4:
					text.texte.text = "Mamie : Et moi j'en ai 90 ! Allez zou, avec tes grandes gambettes là."
				5:
					text.texte.text = "Petite fille : Mais ! Roh et puis zut je viens..."
				_:
					text.texte.text = ""
			livre += 1
			if livre == 6:
				livre = 0
				text.texte.text = " "
				$Kaki_2.visible = false
				$Kaki_3.visible = true

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
	cam_proche.priority = 2
	text.play_anim()
	$DirectionalLight3D.rotation.x += deg_to_rad(3)
	print(str(souvenir).get_slice(":",0))
	if str(souvenir).get_slice(":",0) == "Tele":
		cam_proche.follow_offset = Vector3(-0.3,0.0,0.0)
		tele = 1
		$"Voix off télé meuble".play()
	if str(souvenir).get_slice(":",0) == "Confiture":
		confiture = 1
		cam_proche.follow_offset = Vector3(0.0,0.1,0.0)
		$"Voix off Confiture".play()
		$"glass pick up".play()
	if str(souvenir).get_slice(":",0) == "Barbie":
		cam_proche.follow_offset = Vector3(0.0,-0.3,0.0)
		$"Voix off Poupée".play()
		barbie = 1
	if str(souvenir).get_slice(":",0) == "Livre_020":
		cam_proche.follow_offset = Vector3(0.3,0.0,0.0)
		livre = 1
	if str(souvenir).get_slice(":",0) == "Roues":
		roues = 1
		$"Voix off Vélo".play()
	if str(souvenir).get_slice(":",0) == "Masque":
		masque = 1
		$"Voix off masque cousu".play()
		cam_proche.follow_offset = Vector3(0.0,-0.1,0.0)


func _on_chat_miaulement_finished() -> void:
	$"chat miaulement".play()
