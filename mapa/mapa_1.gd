extends Node2D
func _ready():
	if !$AudioStreamPlayer2D.playing:
		$AudioStreamPlayer2D.play()
