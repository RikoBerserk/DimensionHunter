extends NinePatchRect

var battle ="res://Battle scene/battleBoss.tscn"

signal dialogue_finished
var space = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("ui_accept"):
		space += 1
	match space:
		1:
			$Label.text = "[Generale G.M.]: Finalmente ho l'onore di incontrarti!
			Lascia che mi presenti: Sono il generale Morghul del Genesisi Mundi!
			Non aspettavo altro che questo momento!"
	
		2:
			$Label.text = "[Generale Morghul]: Gli Hunter devono essere a corto di guerrieri per reclutare
	un moccioso come te, ahaha. "
		3:			
			hide()
			set_process(false)
			emit_signal("dialogue_finished")
			
		
	
	

			var x = $"../../Player".position.x
			var y = $"../../Player".position.y
			SceneSwitcher.switch_scene(battle, x, y)
			queue_free()

			
		

func _on_player_dialogue_boss():
	show()
	set_process(true)
	space = 1
