class_name BTWait, "icons/btwait.svg"
extends BTNode

#export(bool) var isAgentReaction = false
export(float) var waitTime 

# warning-ignore:unused_argument
func Tick(agent: Node, blackboard: Blackboard):
#	if isAgentReaction and fresh:
#		if not "reaction_time" in agent:
#			isActive = false
	if not isActive:
		return
	else:
		fresh = false
	if Running():
		return
	if debug:
		print(name)
#	if isAgentReaction:
#		waitTime = agent.reactionTime
	Run()
	yield(get_tree().create_timer(waitTime, false), "timeout")
	Succeed()
