extends Node3D

@export var fade_out : ColorRect
@export var label : RichTextLabel
@export var credit : RichTextLabel
@export var mamie : Node3D
@export var musique : AudioStreamPlayer3D

func _ready() -> void:
	var tween_cim = get_tree().create_tween()
	tween_cim.tween_property(fade_out,"modulate",Color((Color.BLACK),0.0),5.0)
	var controlleur_mamie = mamie.get_node("Controlleur_mamie")
	controlleur_mamie.can_move = false

func _on_timer_timeout() -> void:
	musique.play(4.0)

func _on_timer_fin_timeout() -> void:
	var tween_fin = get_tree().create_tween()
	tween_fin.tween_property(label,"modulate",Color((Color.WHITE),1.0),5.0)
	await tween_fin.finished
	tween_fin = get_tree().create_tween()
	tween_fin.tween_property(credit,"modulate",Color((Color.WHITE),1.0),10.0)
