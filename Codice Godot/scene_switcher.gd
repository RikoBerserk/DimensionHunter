extends Node
var X = 0
var Y = 0

var current_scene = null
func _ready():
	var  root = get_tree().root
	current_scene= root.get_child(root.get_child_count()-1)
	
func switch_scene(res_path, x, y):
	
	if x==0:
		call_deferred("_deferred_switch_scene", res_path, X, Y)
	else:
		X = x
		Y = y
		call_deferred("_deferred_switch_scene", res_path, x, y)

func _deferred_switch_scene(res_path,x,y):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	current_scene.get_node("Player").position = Vector2(x,y)
