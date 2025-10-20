extends Node3D

signal changer_deplacement(rotation_guizmo)

@export var pcam_milieu : PhantomCamera3D
@export var pcam_gauche : PhantomCamera3D
@export var pcam_droite : PhantomCamera3D
@export var pcam_livre : PhantomCamera3D
@export var pcam_barbie : PhantomCamera3D
@export var pcam_masque : PhantomCamera3D
@export var pcam_tele : PhantomCamera3D
@export var pcam_roues : PhantomCamera3D
@export var pcam_confiture : PhantomCamera3D
@export var cam_proche : PhantomCamera3D
@export var text : Control
@export var intro_outro : Control
@export var mamie : Node3D
@export var timer : Timer
var controlleur_mamie : CharacterBody3D

var interactible : Array[Node]
var hitbox_objets : Array[Node3D]
var objet_trouve : Array[bool]
var pcam_tab : Array[PhantomCamera3D] = []

@export var nb_objet := 6
var can_talk = true

var masque : int = 0
var confiture : int = 0
var roues : int = 0
var livre : int = 0
var barbie : int  = 0
var tele : int = 0

func _ready() -> void:
	pcam_tab = [pcam_milieu,pcam_gauche, pcam_droite,cam_proche,pcam_livre,pcam_barbie,pcam_masque,pcam_tele,pcam_roues,pcam_confiture]
	controlleur_mamie = mamie.get_node("Controlleur_mamie")
	changer_deplacement.connect(controlleur_mamie.rotate_guizmo.bind())
	interactible = get_tree().get_nodes_in_group("objets_interaction")
	hitbox_objets.resize(interactible.size())
	for i in interactible.size():
		hitbox_objets[i] = interactible[i].get_parent()
	objet_trouve.resize(nb_objet)
	print(hitbox_objets)
	intro_outro.end_intro.connect(_start_house.bind())
	
func _start_house():
	$"radio click + musique radio".play()
	$"Ambiance maison intérieur".play()
	timer.start()


func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("Interraction"):
		#var index = 0
		#for i in interactible:
			#if i.selected :
				#choix_souvenirs(hitbox_objets[index])
			#index += 1
	#if event.is_action_pressed("fin_dialogue"):
		#fin_dialogue()
		
	if event.is_action_pressed("suite_dialogue"):
		if cam_proche.priority == 1 :
			if tele != 0:
				match tele:
					1:
						text.texte.text = "La fille : Alors, j’ai entendu que Papa allait amener la télé à la décharge vu qu’elle ne marche plus, puis en racheter une autre. Mais Mama voulait la garder."
					2:
						text.texte.text = "La fille : Donc j’ai pensée qu'en la repeignant, on peut en faire un meuble où on pose la nouvelle télé au dessus de la grosse. Comme ça, on ne la jette pas et on s’en sert pour la nouvelle télé!!!"
					3:
						text.texte.text = "Papie : Ben, j’ai pas dit que j’allais la jeter, j’ai dit que j’allais l'emmener à la décharge, je connais quelqu’un qui voulait la réparer."
					4:
						text.texte.text = "Mamie : (rigole) Au moins c’est très jolie comme ça."
					_:
						text.texte.text =  " "
				tele += 1
				if tele == 6 :
					tele = 0
					objet_trouve[3] = true
					text.texte.text = " "
					pcam_tele.priority = 0
					$"Voix off télé meuble".stop()
					fin_dialogue()
			if confiture != 0:
				match confiture:
					1:
						text.texte.text = "Mamie : Il reste du café ? Je prend la confiture."
					2:
						text.texte.text = "Papie : Tiens (touse)."
					3:
						text.texte.text = "Mamie : Notre fils a appelé, apparemment ce sera une petite fille."
					4:
						text.texte.text = "Papie : Vraiment ? (tousse)."
					5:
						text.texte.text = "Mamie : En pleine forme, en plus elle a déjà une dent, tu te rends compte?!"
					6:
						text.texte.text = "Papie : (tousse) (tousse) Ils sont heureux ?"
					7:
						text.texte.text = "Mamie : Mais bien sur qu’ils sont heureux, ils sont très bien nos deux enfants. . . Tu vas bien ?"
					8:
						text.texte.text = "Papie : (tousse) (tousse) (tousse)"
					_:
						text.texte.text = " "
				confiture += 1
				if confiture == 10:
					confiture = 0
					objet_trouve[5] = true
					text.texte.text = " "
					$"glass put down".play()
					$Kaki_3.visible = false
					$Kaki_4.visible = true
					$"Voix off Confiture".stop()
					pcam_confiture.priority = 0
					fin_dialogue()
			if barbie != 0:
				match barbie:
					1:
						text.texte.text = "Petite fille : Regarde, regarde, regarde !"
					2:
						text.texte.text = "Fille : Mais qu’est ce que tu as trouvé ?"
					3:
						text.texte.text = "Mamie : Oh mais c’était ta poupée, princesse PQ, tu l’avais fait à partir de ce que tu trouvais dans les toilettes."
					4:
						text.texte.text = "Fille : Aaahh oui !! Est-ce qu’elle a encore du papier dessus ?"
					5:
						text.texte.text = "Mamie : Ah non je l’ai retiré, il prenait l’humidité."
					6:
						text.texte.text = "Fille : Mon frère va pas apprécier s'il apprend qu’elle a joué avec cette vieille poupée."
					_:
						text.texte.text = " "
				barbie += 1
				if barbie == 8 :
					barbie = 0
					objet_trouve[1] = true
					text.texte.text = " "
					$Kaki_5.visible = false
					$Kaki_6.visible = true
					$"Voix off Poupée".stop()
					pcam_barbie.priority = 0
					fin_dialogue()
			if masque != 0:
				match masque:
					1:
						text.texte.text = "Mamie : Tada !!!"
					2:
						text.texte.text = "Fils : Mais c’est quoi ?"
					3:
						text.texte.text = "Mamie : Ben des masques, je les ai fait avec ton père qui m’a aidé."
					4:
						text.texte.text = "Papie : Comme ça tu pourras aller travailler tranquillement au bureau, vu qu’on ne trouve plus de masques en magasin."
					5:
						text.texte.text = "Fils : Ma boîte m’a déjà donné des masques, j’en ais déjà plus de cinquante chez moi tout neuf mamie !"
					6:
						text.texte.text = "Mamie : Ah . . . alors on pourait les donner à ta soeur (rigole), elle a déjà l’autre moitié."
					_:
						text.texte.text = ""
				masque += 1
				if masque == 8:
					masque = 0
					objet_trouve[2] = true
					text.texte.text = " "
					$Kaki_1.visible = false
					$Kaki_2.visible = true
					pcam_masque.priority = 0
					$"Voix off masque cousu".stop()
					fin_dialogue()
			if roues != 0:
				match roues:
					1:
						text.texte.text = "Papie : Alors, j’ai changé les roues, essayé de renforcer les fourches, ajouté une sonnette, retapé les frein . . . mais j’ai bien peur qu’il manque un truc."
					2:
						text.texte.text = "Mamie : Ah bon ? Qu’est ce qu’il manque ?"
					3:
						text.texte.text = "Papie : Une pilote . . . qui aime rouler de longue heures sur les sentiers, et qui n’a pas froid aux yeux devant l'effort !"
					4:
						text.texte.text = "Mamie : Oh toi, alors... "
					_:
						text.texte.text =  ""
				roues += 1
				if roues == 6:
					roues = 0
					objet_trouve[4] = true
					text.texte.text = " "
					$Kaki_6.visible = false
					$Kaki_7.visible = true
					$"Voix off Vélo".stop()
					$"Cat purr".play()
					pcam_roues.priority = 0
					fin_dialogue()
			if livre != 0 :
				match livre:
					1:
						text.texte.text = "Petite fille : Bon mamie, où est ce qu'on va ce soir ?"
					2:
						text.texte.text = "Mamie : Y a Jeanne la conteuse qui vient au village cette semaine ! Allez viens tu vas voir comme elle est douée."
					3:
						text.texte.text = "Petite fille : Mamie, j'ai 20 ans tu sais..."
					4:
						text.texte.text = "Mamie : Et moi j'en ai 90 ! Allez zou, avec tes grandes gambettes là."
					5:
						text.texte.text = "Petite fille : Mais ! Roh et puis zut je viens..."
					_:
						text.texte.text = ""
				livre += 1
				if livre == 7:
					livre = 0
					objet_trouve[0] = true
					text.texte.text = " "
					$Kaki_2.visible = false
					$Kaki_3.visible = true
					pcam_livre.priority = 0
					cam_proche.rotation.y = deg_to_rad(0.0)
					fin_dialogue()
		else :
			if can_talk :
				var index = 0
				for i in interactible:
					if i.selected :
						choix_souvenirs(hitbox_objets[index])
					index += 1

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
	#cam_proche.follow_target = souvenir
	cam_proche.priority = 1
	controlleur_mamie.can_move = false
	text.play_anim()
	$DirectionalLight3D.rotation.x += deg_to_rad(3)
	print(str(souvenir).get_slice(":",0))
	if str(souvenir).get_slice(":",0) == "Tele":
		#cam_proche.follow_offset = Vector3(-0.3,0.0,0.0)
		pcam_tele.priority = 2
		tele = 1
		$"Voix off télé meuble".play()
	if str(souvenir).get_slice(":",0) == "Confiture":
		confiture = 1
		pcam_confiture.priority = 2
		cam_proche.follow_offset = Vector3(0.0,0.1,0.0)
		$"Voix off Confiture".play()
		$"glass pick up".play()
	if str(souvenir).get_slice(":",0) == "Barbie":
		#cam_proche.follow_offset = Vector3(0.0,-0.3,0.0)
		#cam_proche.rotation.y = deg_to_rad(-30.0)
		pcam_barbie.priority = 2
		$"Voix off Poupée".play()
		barbie = 1
	if str(souvenir).get_slice(":",0) == "Livre_020":
		#cam_proche.follow_offset = Vector3(0.0,1.0,0.0)
		#cam_proche.rotation.y = deg_to_rad(44.5)
		cam_proche.rotation = Vector3(-11.5,43.5,0.0)
		pcam_livre.priority = 2
		livre = 1
		$"Tourner une page".play()
	if str(souvenir).get_slice(":",0) == "Roues":
		roues = 1
		pcam_roues.priority = 2
		#cam_proche.follow_offset = Vector3(0.0,1.0,0.0)
		$"Voix off Vélo".play()
	if str(souvenir).get_slice(":",0) == "Masque":
		masque = 1
		pcam_masque.priority = 2
		$"Voix off masque cousu".play()
		#cam_proche.follow_offset = Vector3(0.0,0.5,0.0)

func _on_chat_miaulement_finished() -> void:
	$"chat miaulement".play()

func fin_dialogue():
		text.play_anim()
		cam_proche.priority = 0
		barbie = 0
		tele = 0
		livre = 0
		roues = 0
		confiture = 0
		masque = 0
		$"obtain".play()
		controlleur_mamie.can_move = true
		text.texte.text = "Souvenirs de mamie..."
		print(objet_trouve)
		if objet_trouve.count(false) == 0 :
			can_talk = false
			intro_outro.apparaitre()
			$"radio click + musique radio".stop()
			$"click de fin radio".play()

func _on_tourner_une_page_finished() -> void:
	if livre != 0 :
		$"Tourner une page".play()


func _on_timer_timeout() -> void:
	intro_outro.hide()
	intro_outro.modulate.a = 0.0
	$"chat miaulement".play()
	$"Pas sol intérieur".play()
