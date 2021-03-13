extends BTLeaf

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	if agent.ammo <= 0:
		return fail()
	
	yield(get_tree().create_timer(.4, false), "timeout")
	agent.ammo -= 1
	
	return succeed()
