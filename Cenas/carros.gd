extends RigidBody2D

func _ready() -> void:
	var tipos_carros = $Animacao.sprite_frames.get_animation_names()
	var carro = tipos_carros[randi_range(0, tipos_carros.size() - 1)]
	$Animacao.animation = carro


func _on_notificador_screen_exited() -> void:
	queue_free()
