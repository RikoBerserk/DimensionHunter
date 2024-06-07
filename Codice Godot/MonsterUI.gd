extends Control

var maxHealth
# Called when the node enters the scene tree for the first time.
func _ready():
	
	await get_tree().create_timer(1).timeout
	maxHealth =  $"../Enemy".get_child(0).Health
	$HPBarM.max_value = $"../Enemy".get_child(0).Health
	$HPBarM.value = $"../Enemy".get_child(0).Health
	

func _process(_delta):
	$HPBarM.value = $"../Enemy".get_child(0).Health
	$HPTxtM.text = str($"../Enemy".get_child(0).Health) + "/" + str(maxHealth)
	$InfoM.text = str($"../Enemy".get_child(0).name) + " LV. " + str($"../Enemy".get_child(0).Level)
