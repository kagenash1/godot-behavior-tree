class_name BTWait, "res://addons/behavior_tree/icons/btwait.svg"
extends BTLeaf

# Waits for wait_time seconds, then succeeds.

export(float) var wait_time 



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	yield(get_tree().create_timer(wait_time, false), "timeout")
	return succeed()
