extends CharacterBody2D

@export var speed = 2

signal dialogue_npc1
signal dialogue_npc2
signal dialogue_npc3
signal dialogue_npc4
signal dialogue_npc5
signal dialogue_npc6
signal dialogue_npc7
signal dialogue_boss
signal potion

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	# Inizializzo il vettore "velocity"
	var velocity = Vector2.ZERO
		
	# Aggiorno il vettore velocity in base all'input del giocatore
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		velocity.y = -1
		$RayCast2D.target_position.x = 0
		$RayCast2D.target_position.y = -50
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_S):
		velocity.y = 1
		$RayCast2D.target_position.x = 0
		$RayCast2D.target_position.y = 50
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		velocity.x = -1
		$RayCast2D.target_position.x = -50
		$RayCast2D.target_position.y = 0
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		velocity.x = 1
		$RayCast2D.target_position.x = 50
		$RayCast2D.target_position.y = 0
	
	# Aggiorno la posizione del nodo Player.
	# La nuova posizione è uguale alla vecchia posizione sommata al vettore di spostamento normalizzato
	
	var movement = velocity.normalized() * speed 
	self.move_and_collide(movement)
	self.update_animation(velocity)
	
	var collider = $RayCast2D.get_collider()
	if collider != null and Input.is_action_just_released("ui_accept"): 
		if "npc1" in collider.name:
			emit_signal("dialogue_npc1")
			set_process(false)
		if "npc2" in collider.name:
			emit_signal("dialogue_npc2")
			set_process(false)
		if "npc3" in collider.name:
			emit_signal("dialogue_npc3")
			set_process(false)
		if "npc4" in collider.name:
			emit_signal("dialogue_npc4")
			set_process(false)
		if "npc5" in collider.name:
			emit_signal("dialogue_npc5")
			set_process(false)
		if "npc6" in collider.name:
			emit_signal("dialogue_npc6")
			set_process(false)
		if "boss" in collider.name:
			emit_signal("dialogue_boss")
			set_process(false)
		if "npc7" in collider.name:
			emit_signal("dialogue_npc7")
			set_process(false)
		if "potion1" in collider.name:
			emit_signal("potion")
			$"../Potion/potion1".hide()
			set_process(false)
		if "potion2" in collider.name:
			emit_signal("potion")
			$"../Potion/potion2".hide()
			set_process(false)
		if "potion3" in collider.name:
			emit_signal("potion")
			$"../Potion/potion3".hide()
			set_process(false)
		if "potion4" in collider.name:
			emit_signal("potion")
			$"../Potion/potion4".hide()
			set_process(false)
		if "potion5" in collider.name:
			emit_signal("potion")
			$"../Potion/potion5".hide()
			set_process(false)
		if "potion6" in collider.name:
			emit_signal("potion")
			$"../Potion/potion6".hide()
			set_process(false)
		if "potion7" in collider.name:
			emit_signal("potion")
			$"../Potion/potion7".hide()
			set_process(false)
		if "potion8" in collider.name:
			emit_signal("potion")
			$"../Potion/potion8".hide()
			set_process(false)
		if "potion9" in collider.name:
			emit_signal("potion")
			$"../Potion/potion9".hide()
			set_process(false)
		if "potion10" in collider.name:
			emit_signal("potion")
			$"../Potion/potion10".hide()
			set_process(false)
		if "potion11" in collider.name:
			emit_signal("potion")
			$"../Potion/potion11".hide()
			set_process(false)
		if "dottoressa" in collider.name:
			emit_signal("dialogue_npc1")
			for i in Game.SelectMonster: #resetto i valori originali dell'health
				Game.SelectMonster[i]["Health"] = Game.SelectMonster[i]["MaxHealth"]
			set_process(false)
		if "professoressa" in collider.name:
			emit_signal("dialogue_npc2")
			set_process(false)
		
			
			
		
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
	

	
func _on_text_box_dialogue_finished():
	set_process(true)


