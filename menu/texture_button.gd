
extends TextureButton

var nova_cena = "res://mapa/mapa1.tscn"

func _on_pressed() -> void:
	get_tree().change_scene_to_file(nova_cena)
pass
