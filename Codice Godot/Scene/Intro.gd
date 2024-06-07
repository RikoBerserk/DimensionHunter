extends Node2D

@onready var music1 = $MusicIntro
var i = 0
var scena = "res://main.tscn"
var skip = 1
var spawn = 0
func _ready():
	set_process(true)
	$dottoressaHofstadter.hide()
	$TextIntro/Label.hide()
	music1.play()

func wait(): #funzione che evita di saltare velocemente tutte le schermate
	skip = 0
	await get_tree().create_timer(0.5).timeout
	skip = 1

func _process(delta):
	
	if Input.is_action_just_released("ui_accept") && skip == 1:
		
		i += 1	
		wait()
		
	match i:
		1:
			$Storia0.hide()
			$TextIntro.show()
			$TextIntro/Label.show()
			$Storia1.show()
			$TextIntro/Label.text = "Era una giornata come tante altre nel regno di Seraphia, 
			la vita scorreva tranquillamente e spensierata,
			finché un giorno non accadde qualcosa di veramente strano..."
		2:
			$Storia1.hide()
			$Storia2.show()
			$TextIntro/Label.text = "Strani e mistici portali apparvero per tutto il regno, sprigionando un' immensa aurea.
			Gli abitanti del regno rimasero allibiti e tale visione.
			Ciò che trovarono era al di la della loro immaginazione..."
		3:	
			$Storia2.hide()
			$Storia3.show()
			$TextIntro/Label.text = "Figure misteriorse fuoriuscivano dai portali, popolando tutto il regno.
			Il mistero della creazione dei portali è ancora tutt'oggi sconosciuto."
		4:

			$Storia3.hide()
			$Storia4.show()
			$TextIntro/Label.text = "Con il passare del tempo, gli uomini riuscirono a conviverci e a domarli. 
			Però, sebbene queste creature siano potenti e affascinanti, potevano rappresentare 
			un problema se catturati da uomini senza scrupolo."
		5: 

			$Storia4.hide()
			$Storia5.show()
			$TextIntro/Label.text = "Da una parte ci sono gli Hunter, che hanno il compito di studiare tali creature, 
			di prendersene cura ed accudirli.
			Il loro obiettivo è la comune convivenza."
		6:

			$Storia5.hide()
			$Storia6.show()
			$TextIntro/Label.text = "Dall'altra parte c'è Nemesis Mundi, un'organizzazione nata con il compito di controllarli 
			per poter sfruttare il loro immenso potere con l'ambizione del dominio su Seraphia..."	
		7:
			$Storia6.hide()
			$Storia7.show()
			$TextIntro/Label.text = "...Talvolta distruggendo intere aree per puro divertimento..."
		8:

			$Storia7.hide()
			$Storia8.show()
			$TextIntro/Label.text = "Nella notte di 10 giorni fa è toccato al tuo villaggio, Iridia,
			c'è stata una lunga lotta tra gli hunter e i Genesis Mundi, ma alla fine hanno prevalso 
			i nemici, distruggendo e incendiando tutta Iridia."
		9:

			$Storia8.hide()
			$Storia9.show()
			$TextIntro/Label.text = "Fu così che decidesti di unirti agli hunter..."
		10:

			$Storia9.hide()
			$TextIntro.hide()
			await get_tree().create_timer(1).timeout
			$generaleRoland.show()
			
		11:
			$TextIntro.show()
			$TextIntro/Label.text = "[Generale Roland]: Salve! Tu devi essere Ethan, giusto?
			Lascia che mi presenti: sono il generale Roland, un tempo ero a capo dell'esercito di 
			liberazione a Seraphia, e adesso mi occupo di combattere quei farabutti del Nemesis
			Mundi."
		12:
			$TextIntro/Label.text = "[Generale Roland]: Quando tutto ciò iniziò, il loro intervento nel prendere il possesso
			di quelle creature fu tempestivo, ma sopratutto pericoloso, come puoi vedere 
			al tuo villaggio..."
		13:
			$TextIntro/Label.text = "[Generale Roland]: Detto ciò, non perdiamoci in chiacchiere.
			Mi hanno detto che ti vuoi unire agli hunter... E' cosi sia!
			Abbiamo sempre bisogno di una mano per combattere quei criminali!"
		14:
			$TextIntro/Label.text = "[Generale Roland]: Ti avviso fin da subito che non sarà un impresa facile.
			Noi siamo stati addestrati per questo momento.
			Abbiamo una causa troppo grande da difendere, ma unendo le forze sono sicuro che ce
			la faremo!!"
		15:
			$TextIntro/Label.text = "[Generale Roland]: Come tua prima missione, ti abbiamo assegnato la città di Celestia.
			Una piccola città, ti ci troverai bene!
			Il tuo compito sarà quello di sconfiggere il generale Morghul, capo della principale 
			squadra del Genesis Mundi."
		16:
			$TextIntro/Label.text = "[Generale Roland]: Ci hanno detto che si sta nascondendo nel castello Drakenhold, 
			situato a nord di Celestia.
			Per i dettagli tecnici ti passo la dottoressa Hoftarder.
			Devo scappare adesso... Ci vediamo!!"
	
		17:
			$generaleRoland.hide()
			$TextIntro.hide()
			await get_tree().create_timer(1).timeout
			$dottoressaHofstadter.show()
			
		18:
			$TextIntro.show()
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Salve Ethan piacere di conoscerti!
			Sono la dottoressa Emily Hofstarder, mi occupo di ricerca sulle creature,
			cerco di studiarli e capire come siano arrivati a Serphia."
		19:
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Ho raccolto una vasta quantità di informazioni sulle creature 
			che popolano queste terre. Sono qui per condividere le mie conoscenze con voi 
			e aiutarvi a comprendere meglio i vostri avversari. 
			Ricordatevi, la conoscenza è la chiave per la sopravvivenza."
		20:
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Avete intenzione di cacciare i mostri di queste terre? 
			Bhe se volete sconfiggere il Genesis Mundi mi sembra ovvio, però prima di farlo,
			lasciate che vi fornisca qualche consiglio basato sulle mie ricerche."
			
		21:
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Ogni creatura ha le sue peculiarità e i suoi punti deboli, 
			conoscerli vi renderà più efficaci nei vostri scontri. 
			A turno, ogni creatura può usare una delle tre mosse, solo una mossa prevarrà 
			sull'altra, sarà la tua o quella del nemico?"
		22:
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Ricorda: puoi muoverti all'interno della mappa usando le frecce 
			direzionali, puoi aprire il menù con -Invio-, e -Spazio- per interagire 
			con gli abitanti di celestia e raccogliere oggetti."
		23:
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Ah, giusto. Quasi dimenticavo...
			Ecco tieni!	"
		24:
			$dottoressaHofstadter.hide()
			if spawn == 0:
				$Monster/AnimationPlayer.play("SpawnIntro")
				spawn = 1
			$TextIntro/Label.text = "
															   - Ottieni Meownster --"
		25:
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Un piccolo regalo per iniziare!
			Prenditene cura e crescilo. 
			Miraccomando!"
		26:
			if spawn == 1:
				$Monster/AnimationPlayer.play_backwards("SpawnIntro")
				spawn = 2
				await get_tree().create_timer(1).timeout
			$dottoressaHofstadter.show()
			$TextIntro/Label.text = "[Dott.ssa Hofstadter]: Adesso devo andare, ma per qualsiasi cosa mi puoi trovare 
			al laboratorio, li ti aiuterò a rimmettere in sesto le tue creature.
			Vieni a trovarmi, a presto!!"
		27:
			if spawn == 2:
				$"ui/AnimationPlayer".play("transitionIn")
				await get_tree().create_timer(1).timeout
				SceneSwitcher.switch_scene(scena, -4714,2090)
				spawn = 3
	
