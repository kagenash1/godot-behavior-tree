extends Node

var is_alive = true
var ammo = 5

func _ready():
	yield(get_tree().create_timer(3, false), "timeout")
	print("\n - Agent: 'Target aquired!'\n")
	$Blackboard.set_data("is_target_aquired", true)
