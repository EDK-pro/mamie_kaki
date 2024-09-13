extends Control

@export var anim : AnimationPlayer
@export var texte : RichTextLabel

var state_anim : bool = true

func play_anim():
	if state_anim :
		anim.play("textbar")
	else: 
		anim.play_backwards("textbar")
	state_anim = !state_anim
