extends CharacterBody2D

@export var speed: float = 300.0
@onready var command_ui: Node = get_tree().get_first_node_in_group("command_ui")

var max_commands: int = 0
var move_dir: Vector2 = Vector2.ZERO
var has_key: bool = false
var command_queue: Array[Vector2] = []
var is_executing: bool = false
var reached_goal: bool = false

func _ready() -> void:
	add_to_group("player")

	var scene_name = get_tree().current_scene.scene_file_path.get_file().get_basename()
	var level_number = scene_name.replace("mapa", "").to_int()

	match level_number:
		1:
			max_commands = 20
		2:
			max_commands = 20
		3:
			max_commands = 20
		4:
			max_commands = 20
		5:
			max_commands = 20
		6:
			max_commands = 20

func _physics_process(delta: float) -> void:
	if is_executing:
		execute_movement(delta)
	else:
		handle_input()

# -----------------------------------------------
# 🕹️ Entrada e controle da fila de comandos
# -----------------------------------------------
func handle_input() -> void:
	if Input.is_action_just_pressed("Move_Up"):
		add_command(Vector2.UP)
	elif Input.is_action_just_pressed("Move_Down"):
		add_command(Vector2.DOWN)
	elif Input.is_action_just_pressed("Move_Left"):
		add_command(Vector2.LEFT)
	elif Input.is_action_just_pressed("Move_Right"):
		add_command(Vector2.RIGHT)
	elif Input.is_action_just_pressed("Cancel"):
		if not command_queue.is_empty():
			command_queue.pop_back()
			print("❌ Último comando removido:", command_queue)
			if command_ui:
				command_ui.update_commands(command_queue)
	elif Input.is_action_just_pressed("Choose"):
		start_execution()

func add_command(direction: Vector2) -> void:
	if command_queue.size() >= max_commands:
		print("⚠️ Limite de comandos atingido! Máximo:", max_commands)
		return

	command_queue.append(direction)
	print("📜 Fila de comandos:", command_queue)
	if command_ui:
		command_ui.update_commands(command_queue)

func start_execution() -> void:
	if command_queue.is_empty():
		print("⚠️ Nenhum comando para executar.")
		return

	is_executing = true
	if command_ui:
		command_ui.clear_panel()

	move_dir = command_queue.pop_front()
	print("▶️ Executando sequência de movimentos...")

# -----------------------------------------------
# 🧭 Execução automática de movimento
# -----------------------------------------------
func execute_movement(delta: float) -> void:
	if move_dir == Vector2.ZERO:
		if command_queue.is_empty():
			is_executing = false
			print("✅ Sequência finalizada.")
			_check_level_end()
			return
		else:
			move_dir = command_queue.pop_front()

	velocity = move_dir * speed
	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var normal = collision.get_normal()
		if normal.dot(move_dir) < -0.9:
			move_dir = Vector2.ZERO
			velocity = Vector2.ZERO
			print("💥 Colisão detectada, indo para o próximo comando...")
			return

# -----------------------------------------------
# 🧩 Checa se o jogador chegou no objetivo
# -----------------------------------------------
func _check_level_end() -> void:
	if reached_goal:
		print("🎉 Fase completa! Indo para o próximo nível...")
		return

	print("❌ Fase falhou — movimentos acabaram e objetivo não foi alcançado.")
	reset_level()

# -----------------------------------------------
# 🔄 Reinicia a fase
# -----------------------------------------------
func reset_level() -> void:
	print("🔁 Reiniciando fase...")
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()

# -----------------------------------------------
# 🏁 Chamado pela abóbora quando o jogador encosta
# -----------------------------------------------
func on_reach_goal() -> void:
	reached_goal = true
