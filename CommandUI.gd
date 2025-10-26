extends HBoxContainer

@export var arrow_up: Texture2D
@export var arrow_down: Texture2D
@export var arrow_left: Texture2D
@export var arrow_right: Texture2D

# Atualiza o painel conforme a fila do jogador
func update_commands(commands: Array[Vector2]) -> void:
	clear_panel()
	for dir in commands:
		var icon := TextureRect.new()
		icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.custom_minimum_size = Vector2(48, 48)
		
		match dir:
			Vector2.UP:
				icon.texture = arrow_up
			Vector2.DOWN:
				icon.texture = arrow_down
			Vector2.LEFT:
				icon.texture = arrow_left
			Vector2.RIGHT:
				icon.texture = arrow_right

		add_child(icon)

func clear_panel() -> void:
	for child in get_children():
		child.queue_free()
