extends BTLeaf

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	assert("ammo" in agent)
	
	yield(get_tree().create_timer(2, false), "timeout")
	agent.ammo = 5
	return succeed()
