class_name BTConditional, "icons/btconditional.svg" 
extends BTNode

export(Dictionary) var blackboardEntries: Dictionary
export(Dictionary) var agentProperties: Dictionary

func _ready():
	assert(blackboardEntries.size() > 0 or agentProperties.size() > 0)
	for key in blackboardEntries.keys():
		assert(key is String)
	for key in agentProperties.keys():
		assert(key is String)

# warning-ignore:unused_argument
func Tick(agent: Node, blackboard: Blackboard):
	if fresh:
		for key in blackboardEntries.keys():
			if not blackboard.HasData(key):
				isActive = false
		for key in agentProperties.keys():
			if not key in agent:
				isActive = false
	if not isActive:
		return
	else:
		fresh = false
	if debug:
		print(name)
	if blackboardEntries.size() > 0:
		for key in blackboardEntries.keys():
			if blackboard.GetData(key) != blackboardEntries[key]:
				Fail()
				return
	if agentProperties.size() > 0:
		for key in agentProperties.keys():
			if agent.get(key) != agentProperties[key]:
				Fail()
				return
	Succeed()
