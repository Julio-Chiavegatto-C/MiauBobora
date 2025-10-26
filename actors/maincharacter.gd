extends CharacterBody2D

@export var speed: float = 300.0
var move_dir: Vector2 = Vector2.ZERO

var has_key: bool = false 

func _ready():
	add_to_group("player")  

func _physics_process(delta: float) -> void:
	if move_dir == Vector2.ZERO:
		move_dir = get_input_direction()

	if move_dir != Vector2.ZERO:
		velocity = move_dir * speed
		move_and_slide()

		# Verifica colisões e direção do impacto
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var normal = collision.get_normal()

			# Só para se a colisão estiver realmente na direção contrária do movimento
			if normal.dot(move_dir) < -0.9:
				move_dir = Vector2.ZERO
				velocity = Vector2.ZERO
				break


func get_input_direction() -> Vector2:
	var dir = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		dir = Vector2.UP
	elif Input.is_action_pressed("ui_down"):
		dir = Vector2.DOWN
	elif Input.is_action_pressed("ui_left"):
		dir = Vector2.LEFT
	elif Input.is_action_pressed("ui_right"):
		dir = Vector2.RIGHT
	return dir
