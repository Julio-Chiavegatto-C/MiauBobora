extends StaticBody2D

@export var player_group: String = "player"
@export var required_flag: String = "has_key"

@onready var detector: Area2D = $Detector
@onready var sprite: AnimatedSprite2D = $door
@onready var door_collision: CollisionShape2D = $CollisionShape2D
@onready var detector_collision: CollisionShape2D = $Detector/CollisionShape2D

var is_opening: bool = false

func _ready() -> void:
	detector.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if is_opening:
		return

	if body.is_in_group(player_group):
		if required_flag in body and body.get(required_flag):
			open_door()
		else:
			print(" A porta está trancada. Você precisa da chave!")

func open_door() -> void:
	is_opening = true
	print(" Porta abrindo...")

	detector_collision.disabled = true

	if sprite.sprite_frames.has_animation("opening"):
		sprite.play("opening")

	await sprite.animation_finished

	door_collision.disabled = true

	print(" Porta aberta — colisão removida, o jogador pode passar!")

	queue_free()
