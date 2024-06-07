extends CanvasLayer

const MonsterScreen = preload("res://monster_screen.tscn")
const PotionScreen = preload ("res://potion_screen.tscn")

@onready var select_arrow = $Control/NinePatchRect/TextureRect
@onready var menu = $Control
@onready var music = $TextBox/AudioStreamPlayer

enum ScreenLoaded {NOTHING, JUST_MENU, PARTY_SCREEN, POTION_SCREEN}
var screen_loaded = ScreenLoaded.NOTHING
var current_screen = null

var selected_option: int = 0

func _ready():
	menu.visible = false
	select_arrow.position.y = 25 + (selected_option % 4) * 52
	
func load_monster_screen():
	menu.visible = false
	screen_loaded = ScreenLoaded.PARTY_SCREEN
	current_screen = MonsterScreen.instantiate()
	add_child(current_screen)


func load_potion_screen():
	menu.visible = false
	screen_loaded = ScreenLoaded.POTION_SCREEN
	current_screen = PotionScreen.instantiate()
	add_child(current_screen)

func unload_screen():
	if current_screen:
		current_screen.queue_free()
		current_screen = null
	menu.visible = true
	screen_loaded = ScreenLoaded.JUST_MENU
	
func _unhandled_input(event):
	match screen_loaded:
		ScreenLoaded.NOTHING:
			if event.is_action_pressed("menu"):
				Game.changeStop(true)
				var player = get_parent().get_node("Player")
				player.set_process(false)
				
				menu.visible = true
				screen_loaded = ScreenLoaded.JUST_MENU
				
		ScreenLoaded.JUST_MENU:
			if event.is_action_pressed("esc") :#or event.is_action_pressed("menu"):
				var player = get_parent().get_node("Player")
				player.set_process(true)
				menu.visible = false
				Game.changeStop(false)
				screen_loaded = ScreenLoaded.NOTHING
			elif event.is_action_pressed("ui_down"):
				selected_option += 1
				select_arrow.position.y = 25 + (selected_option % 4) * 52
				print(select_arrow.position.y)
			elif event.is_action_pressed("ui_up"):
				if selected_option == 0:
					selected_option = 4
				else:
					selected_option -= 1
					select_arrow.position.y = 25 + (selected_option % 4) * 52
			elif event.is_action_pressed("ui_accept"):
				if select_arrow.position.y == 25:
					load_monster_screen()
				if select_arrow.position.y == 77:
					load_potion_screen()
				if select_arrow.position.y == 129:
					print("Coming soon")		
				if select_arrow.position.y == 181:
					Utils.save_game()
					$TextBox.show()
					$TextBox/Label.text = "Salvataggio in corso..."
					await get_tree().create_timer(1).timeout
					$TextBox/Label.text = "Salvataggio in corso... ..."
					await get_tree().create_timer(1).timeout
					music.play()
					$TextBox/Label.text = "Salvataggio completato!"
					await get_tree().create_timer(1).timeout
					$TextBox.hide()
		
		ScreenLoaded.PARTY_SCREEN:
			if event.is_action("esc"):
				unload_screen()
				
		ScreenLoaded.POTION_SCREEN:
			if event.is_action("esc"):
				unload_screen()
