extends BTDecorator


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	assert("is_alive" in agent)
	
	if not blackboard.has_data("is_target_aquired"):
		return fail()
	
	if agent.get("is_alive") and blackboard.get_data("is_target_aquired"):
		print("\t yes")
		return ._tick(agent, blackboard)
	else:
		print("\t no")
		return fail()
