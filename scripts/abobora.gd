extends Area2D

@export var FILE_BEGIN: String = "res://mapa/mapa"  # Caminho base dos mapas

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print("🎃 VocÊ tocou a abóbora! Indo para o próximo nível...")
		go_to_next_level()

func go_to_next_level() -> void:
	var current_scene = get_tree().current_scene
	if not current_scene:
		return
	
	var current_path = current_scene.scene_file_path
	var current_name = current_path.get_file().get_basename() # Ex: "mapa1"
	var level_number = current_name.replace("mapa", "").to_int()
	var next_level_number = level_number + 1
	
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	
	if ResourceLoader.exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("🏁 Última fase!")
		
