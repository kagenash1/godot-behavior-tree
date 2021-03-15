extends BTLeaf

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	yield(get_tree().create_timer(2, false), "timeout")
	agent.ammo = 5
	return succeed()
