extends Node3D

@export var mamie : CharacterBody3D
@export var area : Area3D

func _ready() -> void:
	area.arrivee_joueureuse.connect(mamie.objet_dessus)
