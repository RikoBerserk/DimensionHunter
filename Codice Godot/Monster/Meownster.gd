extends StaticBody2D


var Health = 20
var Level = 1

func _ready():
	$Panel.hide()
	Level = randi_range(1,3)
	spawn()
	$Aim/Attack.hide()
	
func spawn():
	$AnimationPlayer.play("Spawn", -1, 2)
	await get_tree().create_timer(1).timeout
	$AnimatedSprite2D.play("play", -1, 2)

func Death():
	$AnimatedSprite2D.play("death")

func Hit(Aim, Damage):
	Health -= Damage
	$Aim/Attack.show()
	$Aim/Attack.play(Aim)
	
func Capture():
	$Panel.show()
	$AnimationPlayer.play("Capture", -1,3)
	await $AnimationPlayer.animation_finished
	$"../../UI"._on_scappa_pressed()

func _on_attack_animation_finished():
	$Aim/Attack.hide()
