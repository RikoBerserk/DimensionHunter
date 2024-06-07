extends CanvasLayer

@onready var music = $AudioStreamPlayer2D
var Brancaterra = preload("res://Monster/Brancaterra.tscn")


var selected = 0
var sceltaEnemy = 1
var exp = 100

func _ready():
	music.play()
	var montemp = 0 
	montemp = Brancaterra.instantiate()

			
	$Enemy.add_child(montemp)
	$UI/Menu.hide()
	$UI/Switch.hide()
	$UI/Fight.hide()
	$UI/Menu/GridContainer/Lotta.grab_focus()
	
	var level = 15
	$Enemy.get_child(0).Level = level
	$Enemy.get_child(0).Health = 75
	
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
	var damage =  randi_range(30, 40)
	sceltaEnemy = randi_range(1,3)
	
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
		SceneSwitcher.switch_scene("res://Scene/end.tscn", 0,0)
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
	$Player.get_child(selected).Hit("attacco1", damage)
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
	$Action.text = "Non puoi catturarlo"
