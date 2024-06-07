extends CanvasLayer

@onready var music = $AudioStreamPlayer2D

var Meownster = preload("res://Monster/Meownster.tscn")
var Bluzilla = preload("res://Monster/Bluzilla.tscn")
var Petrogolem = preload("res://Monster/Petrogolem.tscn")
var Brancaterra = preload("res://Monster/Brancaterra.tscn")
var Ariokh = preload("res://Monster/Ariokh.tscn")

var selected = 0
var sceltaEnemy = 1
var exp = 0
func _ready():
	
	music.play()
	var montemp = 0 
	var scelta = randi_range(1,5)
	if scelta == 1:
		montemp = Meownster.instantiate()
	elif scelta == 2:
		montemp = Bluzilla.instantiate()
	elif scelta == 3:
		montemp = Petrogolem.instantiate()
	elif scelta == 4:
		montemp = Brancaterra.instantiate()
	elif scelta == 5:
		montemp = Ariokh.instantiate()
			
	$Enemy.add_child(montemp)
	$UI/Menu.hide()
	$UI/Switch.hide()
	$UI/Fight.hide()
	$UI/Menu/GridContainer/Lotta.grab_focus()
	
	await get_tree().create_timer(2).timeout
	var k = 0
	for i in Game.SelectMonster:
		if Game.SelectMonster[i]["Health"] > 0:
			var monTemp = Game.SelectMonster[i]["Scene"].instantiate()
			monTemp.name = Game.SelectMonster[i]["Name"]
			monTemp.hide()
			$Player.add_child(monTemp)
			if k == 0:
				selected = i
				k = 1
	$Player.get_child(0).show()
	$UI/Menu.show()
		
		
func _process(delta):
	pass

func MonsterTurn(sceltaPlayer, damagePlayer, attack):
	$UI/Menu.hide()
	$UI/Switch.hide()
	$UI/Fight.hide()
	#specifico il danno in base al livello
	var damage = 1

	if $Enemy.get_child(0).Level == 1:
		damage = randi_range(5,7)
		exp = 10
	elif $Enemy.get_child(0).Level == 2:
		damage = randi_range(6,9)
		exp = 12
	elif $Enemy.get_child(0).Level == 3:
		damage = randi_range(8,13)
		exp = 14
	
	if sceltaEnemy == 4: #inizia nuovamente il ciclo
		sceltaEnemy -= 3
	if sceltaEnemy == 1: #sasso
		if sceltaPlayer == "forbice": #sconfitta player
			$Action.text = "Il nemico ha usato sasso...\nTi infligge "+ str(damage) + " danni"
			winEnemy(damage)
		if sceltaPlayer == "carta": #vittoria player
			$Action.text = "Hai vinto! Infliggi " + str(damagePlayer) + " danni al nemico"
			winPlayer(damagePlayer, attack)
		if sceltaPlayer == "sasso": #pareggio
			$Action.text = "Pareggio. \nEntrambi avete usato la stessa mossa"
			pareggio(damage,damagePlayer, attack)
	if sceltaEnemy == 2: #forbice
		if sceltaPlayer == "forbice": #pareggio
			$Action.text = "Pareggio. \nEntrambi avete usato la stessa mossa"
			pareggio(damage,damagePlayer, attack)
		if sceltaPlayer == "carta": #sconfitta player
			$Action.text = "Il nemico ha usato forbice...\nTi infligge "+ str(damage) + " danni"
			winEnemy(damage)
		if sceltaPlayer == "sasso": #vittoria player
			$Action.text = "Hai vinto! Infliggi " + str(damagePlayer) + " danni al nemico"
			winPlayer(damagePlayer, attack)
	if sceltaEnemy == 3: #carta
		if sceltaPlayer == "forbice":  #vittoria player
			$Action.text = "Hai vinto! Infliggi " + str(damagePlayer) + " danni al nemico"
			winPlayer(damagePlayer, attack)
		if sceltaPlayer == "carta":  #pareggio
			$Action.text = "Pareggio. \nEntrambi avete usato la stessa mossa"
			pareggio(damage,damagePlayer, attack)
		if sceltaPlayer == "sasso": #sconfitta player
			$Action.text = "Il nemico ha usato carta...\nTi infligge "+ str(damage) + " danni"
			winEnemy(damage)
	
	sceltaEnemy += 1
	
	$UI/Menu.show()
	$UI/Menu/GridContainer/Lotta.grab_focus()
	
func controlEnemy():
	if $Enemy.get_child(0).Health <= 0:
		#aggiungo l'esperienza e mostro a video i progressi come la vita e la potenza aumentata
		var level = Game.SelectMonster[selected]["Level"]
		var health = Game.SelectMonster[selected]["MaxHealth"]
		var strenght = Game.SelectMonster[selected]["Strenght"]
		var Name = Game.SelectMonster[selected]["Name"]
		Game.addExp(exp, Name)
		$Enemy.get_child(0).Death()
		$Action.text = "Congratulazioni! Nemico sconfitto\nHai ottenuto "+ str(exp) +" Exp"
		await get_tree().create_timer(2).timeout
		if level < Game.SelectMonster[selected]["Level"]:
			$Action.text = "Livello aumentato!\n PS + " + str(Game.SelectMonster[selected]["MaxHealth"]-health) + " - Potenza + " + str(Game.SelectMonster[selected]["Strenght"]-strenght)
		await get_tree().create_timer(2).timeout
		SceneSwitcher.switch_scene("res://main.tscn", 0,0)
		queue_free()
		
func controlPlayer():
	if Game.SelectMonster[selected]["Health"] < 0:
		$UI.deathPlayer()

func pareggio(damage,damagePlayer, attack):
	Game.SelectMonster[selected]["Health"] -= damage/2
	$Enemy.get_child(0).Hit(attack, damagePlayer/2)
	await get_tree().create_timer(2).timeout
	$Action.text = "Cosa scegli?"
	controlEnemy()
	controlPlayer()

func winEnemy(damage):
	#$Player.get_child(selected).Hit("attacco1", damage)
	Game.SelectMonster[selected]["Health"] -= damage
	await get_tree().create_timer(2).timeout
	controlPlayer()
	if Game.SelectMonster[selected]["Health"] > 0:
		$Action.text = "Cosa scegli?"
	
func winPlayer(damagePlayer, attack):
	$Enemy.get_child(0).Hit(attack, damagePlayer)
	await get_tree().create_timer(2).timeout
	$Action.text = "Cosa scegli?"
	controlEnemy()

func _on_cattura_pressed(): #cattura e controlla se il mostro è presente nella squadra
	var trovato = false
	if $Enemy.get_child(0).Health <= ($MonsterUI.maxHealth/2):
		for i in Game.SelectMonster:
			var Name = Game.SelectMonster[i]["Name"]
			if Name in $Enemy.get_child(0).name:
				trovato = true

		if(trovato == true):
			$Action.text = "Mostro già presente nella tua squadra"
		else:
			$Enemy.get_child(0).Capture()
			Game.addExp(exp, Game.SelectMonster[selected]["Name"])
			if "Meownster" in $Enemy.get_child(0).name:
				Game.addMonster("Meownster")
			elif "Bluzilla" in $Enemy.get_child(0).name:
				Game.addMonster("Bluzilla")
			elif "Brancaterra" in $Enemy.get_child(0).name:
				Game.addMonster("Brancaterra")
			elif "Petrogolem" in $Enemy.get_child(0).name:
				Game.addMonster("Petrogolem")
			elif "Ariokh" in $Enemy.get_child(0).name:
				Game.addMonster("Ariokh")	
			
	else:
		$Action.text = "Il nemico è ancora in salute"
		await get_tree().create_timer(2).timeout
		$Action.text = "Cosa scegli?"



