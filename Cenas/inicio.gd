extends Node

func _ready() -> void:
	$AudioTema.play()

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://Cenas/main.tscn")
