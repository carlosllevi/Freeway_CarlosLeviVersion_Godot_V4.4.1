extends Node

var cena_carros = preload("res://Cenas/carros.tscn")
var pistas_rapidas_y = [104, 272, 488]
var pistas_lentas_y = [160, 216, 324, 384, 438, 544, 600]
var score = 0
var score2 = 0
var tempo_restante: int=60

func _ready() -> void: #A gente coloca tudo que vai acontecer ao abri a cena principal
	$HUD/Placar.text = str(score) # faz com que o placar atualize de valor
	$HUD2/Placar.text = str(score2)
	$HUD/Placar.position = Vector2(410, 0)
	$HUD2/Placar.position = Vector2(710, 0)
	$HUD/Mensagem.text = " "
	$HUD2/Mensagem.text = " "
	$HUD/Button.hide()
	$HUD2/Button.hide()
	$AudioTema.play()
	randomize()
	$Player.pontua.connect(Callable(self, "_on_player_pontua").bind(1))
	$Player2.pontua.connect(Callable(self, "_on_player_2_pontua").bind(2))

func _on_timer_carros_rapidos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro) 
	var pista_y = pistas_rapidas_y[randi_range(0, pistas_rapidas_y.size() - 1)]
	carro.position = Vector2(+1290, pista_y)
	carro.set_linear_velocity(Vector2(randf_range(-700.0, -720.0), 0))
	#carro.set_linear_velocity(Vector2(randf_range(-0.0, -0.0), 0))
	carro.set_linear_damp(0.0)

func _on_timer_carros_lentos_timeout() -> void:
	var carro = cena_carros.instantiate()
	add_child(carro) 
	var pista_y = pistas_lentas_y[randi_range(0, pistas_lentas_y.size() - 1)]
	carro.position = Vector2(-10, pista_y)
	carro.set_linear_velocity(Vector2(randf_range(300.0, 320.0), 0))
	#carro.set_linear_velocity(Vector2(randf_range(0.0, 0.0), 0))
	carro.set_linear_damp(0.0) 

func _on_player_pontua() -> void:
	if score <= 2:
		score +=1
		$HUD/Placar.text = str(score)
		$AudioPonto.play()
		$Player.position = $Player.posicao_inicial_player1
	if score == 2:
		$HUD/Mensagem.text = "Parabéns, Player 1 Você Venceu!!!"
		$HUD/Button.show()
		$TimerCarrosRapidos.stop()
		$TimerCarrosLentos.stop()
		$AudioVitoria.play()
		$Player. speed = 0
		$Player2. speed = 0

func _on_player_2_pontua() -> void:
	if score2 <= 2:
		score2 +=1
		$HUD2/Placar.text = str(score2)
		$AudioPonto.play()
		$Player2.position = $Player2.posicao_inicial_player2
	if score2 == 2:
		$HUD/Mensagem.text = "Parabéns, Player 2 Você Venceu!!!"
		$HUD/Button.show()
		$TimerCarrosRapidos.stop()
		$TimerCarrosLentos.stop()
		$AudioVitoria.play()
		$Player. speed = 0
		$Player2. speed = 0

func _on_hud_reinicia() -> void:
	get_tree().reload_current_scene()

func _on_timer_timeout() -> void: # timer do game over
	tempo_restante-=1
	$LabelTimer.text = str(tempo_restante)
	if tempo_restante <= 0:
		$Timer.stop()
		$LabelGameOver.text = "Game-Over, Ninguém venceu!!!"
		$HUD/Button.show()
		$TimerCarrosRapidos.stop()
		$TimerCarrosLentos.stop()
		$AudioVitoria.play()
		$Player. speed = 0
		$Player2. speed = 0
