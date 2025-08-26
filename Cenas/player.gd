extends Area2D
signal pontua
# variáveis
@export var speed: float = 100.0 #export serv para fazer aparecer no painel inspetor
var screen_size: Vector2
var posicao_inicial: Vector2 = Vector2(640, 690) 

#funções
func _ready() -> void: 
	screen_size = get_viewport_rect().size # armazena o valor da tela
	position = posicao_inicial #armazenar o valor da posição

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"): # Quando for pressionado a galinah vai andar no sentido Y
		velocity.y -=1
	if Input.is_action_pressed("ui_down"):
		velocity.y +=1
	if Input.is_action_pressed("ui_left"):
		velocity.x -=1
	if Input.is_action_pressed("ui_right"):
		velocity.x +=1
	
	if velocity != Vector2.ZERO:
		velocity = velocity.normalized() * speed

	position += velocity*delta
	position.y = clamp(position.y, 0.0, screen_size.y)

	if velocity.y > 0: 
		$Animacao.play("baixo")
	elif velocity.y < 0: # tem que usar o elfi para ligar os blocos de if
		$Animacao.play("cima")
	else: 
		$Animacao.stop()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "LinhaChegada":
		emit_signal("pontua")
	else: 
		$Audio.play()
		position = posicao_inicial
