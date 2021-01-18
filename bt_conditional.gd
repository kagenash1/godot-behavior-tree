class_name BTConditional, "icons/btconditional.svg" 
extends BTNode

export(Dictionary) var blackboard_entries: Dictionary
export(Dictionary) var agent_properties: Dictionary

func _ready():
	assert(blackboard_entries.size() > 0 or agent_properties.size() > 0)
	for key in blackboard_entries.keys():
		assert(key is String)
	for key in agent_properties.keys():
		assert(key is String)

# warning-ignore:unused_argument
func tick(agent: Node, blackboard: Blackboard):
	if fresh:
		for key in blackboard_entries.keys():
			if not blackboard.has_data(key):
				is_active = false
		for key in agent_properties.keys():
			if not key in agent:
				is_active = false
	if not is_active:
		return
	else:
		fresh = false
	if debug:
		print(name)
	if blackboard_entries.size() > 0:
		for key in blackboard_entries.keys():
			if blackboard.get_data(key) != blackboard_entries[key]:
				fail()
				return
	if agent_properties.size() > 0:
		for key in agent_properties.keys():
			if agent.get(key) != agent_properties[key]:
				fail()
				return
	succeed()
