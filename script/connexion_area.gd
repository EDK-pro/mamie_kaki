extends Area3D

@export var objet : MeshInstance3D
@export var light : OmniLight3D

@export var selected : bool = false

func _on_body_entered(body: Node3D) -> void:
	selected = true


func _on_body_exited(body: Node3D) -> void:
	selected = false
