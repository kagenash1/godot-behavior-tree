class_name BTWait, "icons/btwait.svg"
extends BTNode

export(float) var wait_time 



func _tick(agent: Node, blackboard: Blackboard) -> bool:
	run()
	yield(get_tree().create_timer(wait_time, false), "timeout")
	return succeed()
