extends BTDecorator

func _tick(agent: Node, blackboard: Blackboard) -> bool:
	assert("ammo" in agent)
	
	if agent.ammo <= 0:
		print("\t yes")
		return ._tick(agent, blackboard)
	else:
		print("\t no")
		return fail()
