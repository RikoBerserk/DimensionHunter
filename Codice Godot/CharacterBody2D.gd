extends CharacterBody2D


func _ready():
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# Inizializzo il vettore "velocity"
	var velocity = Vector2()
		
	# Aggiorno il vettore velocity in base all'input del giocatore
	if Input.is_key_pressed(KEY_UP):
		velocity.y = -1
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y = 1
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x = -1
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x = 1
	
	# Aggiorno la posizione del nodo Player.
	# La nuova posizione è uguale alla vecchia posizione sommata al vettore di spostamento normalizzato
	var movement = velocity.normalized()*5
	self.move_and_collide(movement)
	self.update_animation(velocity)
	
func update_animation(velocity):
	if velocity.y == 1:
		$AnimatedSprite2D.play("walk_down")
	elif velocity.y == -1:
		$AnimatedSprite2D.play("walk_up")
	elif velocity.x == -1:
		$AnimatedSprite2D.play("walk_left")
		$AnimatedSprite2D.flip_h = false
	elif velocity.x == 1:
		$AnimatedSprite2D.play("walk_left")
		$AnimatedSprite2D.flip_h = true
		
	# se velocity è nullo
	if velocity == Vector2():
		if $AnimatedSprite2D.animation == 'walk_down':
			$AnimatedSprite2D.play("stand_down")
		elif $AnimatedSprite2D.animation == 'walk_up':
			$AnimatedSprite2D.play("stand_up")
		elif $AnimatedSprite2D.animation == 'walk_left':
			$AnimatedSprite2D.play("stand_left")
		
	
	
	



