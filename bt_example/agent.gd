extends Node

const max_ammo = 10

var is_alive = true
var ammo = max_ammo



func _ready():
	$Blackboard.set_data("target_aquired", false)
	yield(get_tree().create_timer(3, false), "timeout")
	print("\n - Agent: 'Target aquired!'\n")
	$Blackboard.set_data("target_aquired", true)


func _process(delta: float) -> void:
	set_process(false)
	yield(get_tree().create_timer(6.66, false), "timeout")
	$Blackboard.set_data("target_aquired", false)
	yield(get_tree().create_timer(2, false), "timeout")
	$Blackboard.set_data("target_aquired", true)
	set_process(true)
