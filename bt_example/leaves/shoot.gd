extends BTLeaf

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	assert("ammo" in agent)
	
	if agent.ammo <= 0:
		print("No ammo!")
		return fail()
	
	yield(get_tree().create_timer(.4, false), "timeout")
	agent.ammo -= 1
	
	return succeed()
