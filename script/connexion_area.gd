extends Area3D

@export var objet : MeshInstance3D
@export var light : OmniLight3D

signal arrivee_joueureuse
signal depart_joueureuse

func _on_body_entered(body: Node3D) -> void:
	arrivee_joueureuse.emit()
	objet.visible = true


func _on_body_exited(body: Node3D) -> void:
	objet.visible = false
