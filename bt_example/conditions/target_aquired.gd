extends BTConditional

# A conditional node MUST NOT override _tick but only 
# _pre_tick and _post_tick.


# The condition is checked BEFORE ticking. So it should be in _pre_tick.
func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	assert("is_alive" in agent)
	
	if not blackboard.has_data("target_aquired"):
		verified = false
		ignore_reverse = true # This is to ignore the reverse condition flag
		return
	
	ignore_reverse = false
	
	verified = agent.get("is_alive") and blackboard.get_data("target_aquired")
	print(verified)

