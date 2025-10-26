extends Area2D

@export var player_group: String = "player"
@export var flag_name: String = "has_key"

func _on_body_entered(body: Node) -> void:
	if body.is_in_group(player_group):
		if flag_name in body:
			body.set(flag_name, true)
			print(flag_name, " = ", body.get(flag_name))
		else:
			print("O jogador não tem a variável ", flag_name)

		queue_free() 
