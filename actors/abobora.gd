extends Area2D

const FILE_BEGIN = "res://mapa/mapa"

func _on_body_entered(body: Node) -> void:
	# Verifica se quem entrou é o jogador
	if body.is_in_group("player"):
		go_to_next_level(FILE_BEGIN)
		
func go_to_next_level(FILE_BEGIN):
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1

	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
