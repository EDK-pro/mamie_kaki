extends Control

@export var cimetiere : PackedScene
@export var richtext : RichTextLabel
@export var richtextoutro : RichTextLabel
var tween_text
var intro_stat = [0.273,0.435,0.829,0.97,1.0]
var outro_stat = [0.737,1.0]
var index_intro = 0
var index_outro = 0
var intro = true
var outro = false
signal end_intro 
signal end_outro

func _ready() -> void:
	tween_text = get_tree().create_tween()
	tween_text.tween_property(richtext,"visible_ratio",intro_stat[index_intro],1.0)
	index_intro = index_intro + 1
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("suite_dialogue"):
		if intro :
			if index_intro < intro_stat.size():
				tween_text = get_tree().create_tween()
				tween_text.tween_property(richtext,"visible_ratio",intro_stat[index_intro],1.0)
				index_intro = index_intro + 1
			if index_intro == intro_stat.size():
				end_intro.emit()
				index_intro = index_intro + 1
		if outro :
			if index_outro < outro_stat.size():
				tween_text = get_tree().create_tween()
				tween_text.tween_property(richtextoutro,"visible_ratio",outro_stat[index_outro],1.0)
				index_outro = index_outro + 1
			if index_outro == outro_stat.size():
				$Porte_open.play()
				
				index_outro = index_outro + 1

func apparaitre():
	self.show()

	print("VALIDE PAR LA STREET")
	richtext.hide()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate", Color(Color.WHITE,1.0),1.0)
	await tween.finished
	intro = false
	outro = true
	


func _on_porte_open_finished() -> void:
	$Porte_ferme.play()


func _on_porte_ferme_finished() -> void:
	$Pas_gravier.play()


func _on_pas_gravier_finished() -> void:
	get_tree().change_scene_to_packed(cimetiere)
