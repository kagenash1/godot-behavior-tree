class_name BTNode, "res://addons/behavior_tree/icons/btnode.svg" 
extends Node

# Base class from which every node in the behavior tree inherits. 
# You don't usually need to instance this node directly.
# To define your behaviors, use and extend BTLeaf instead.

class BTNodeState:
	var success: bool = true  setget set_success
	var failure: bool = false setget set_failure
	var running: bool = false setget set_running
	
	
	func set_success(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTNodeState. Use setters.")
			return
		success = true
		failure = false
		running = false
	
	
	func set_failure(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTNodeState. Use setters.")
			return
		success = false
		failure = true
		running = false
	
	
	func set_running(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTNodeState. Use setters.")
			return
		success = false
		failure = false
		running = true




# (Optional) Emitted after a tick() call. True is success, false is failure. 
signal tick(result)

# Emitted if abort_tree is set to true
signal abort_tree()

# Turn this off to make the node fail at each tick.
export(bool) var is_active: bool = true 

# Turn this on to print the name of the node at each tick.
export(bool) var debug: bool = false 

# Turn this on to abort the tree after completion.
export(bool) var abort_tree: bool

var state: BTNodeState = BTNodeState.new()



func _ready():
	if is_active:
		succeed()
	else:
		push_warning("Deactivated BTNode '" + name + "', path: '" + get_path() + "'")
		fail()


### OVERRIDE THE FOLLOWING FUNCTIONS ###
# You just need to implement them. DON'T CALL THEM MANUALLY.

func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	pass


# This is where the core behavior goes and where the node state is changed.
# You must return either succeed() or fail() (check below), not just set the state.
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	return succeed()


func _post_tick(agent: Node, blackboard: Blackboard, result: bool) -> void:
	pass

### DO NOT OVERRIDE ANYTHING FROM HERE ON ###



### BEGIN: RETURN VALUES ###

# Your _tick() must return on of the two following funcs.

# Return this to set the state to success.
func succeed() -> bool:
	state.set_success()
	return true


# Return this to set the state to failure.
func fail() -> bool:
	state.set_failure()
	return false


# Return this to match the state to another state.
func set_state(rhs: BTNodeState) -> bool:
	if rhs.success:
		return succeed()
	else:
		return fail()

### END: RETURN VALUES ###



# You are not supposed to use this. 
# It's called automatically. 
# It won't do what you think.
func run():
	state.set_running()


# You can use the following to recover the state of the node
func succeeded() -> bool:
	return state.success


func failed() -> bool:
	return state.failure


func running() -> bool:
	return state.running


# Or this, as a string.
func get_state() -> String:
	if succeeded():
		return "success"
	elif failed():
		return "failure"
	else:
		return "running"


# Again, DO NOT override this. 
func tick(agent: Node, blackboard: Blackboard) -> bool:
	if not is_active:
		return fail()
	
	if running():
		return false
	
	if debug:
		print(name)
	
	# Do stuff before core behavior
	_pre_tick(agent, blackboard)
	
	run() 
	
	var result = _tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		# If you yield, the node must be running.
		# If you crash here it means you changed the state before yield.
		assert(running())
		result = yield(result, "completed")
	
	# If you complete execution (or don't yield anymore), the node can't be running.
	# If you crash here it means you forgot to return succeed() or fail().
	assert(not running()) 
	
	# Do stuff after core behavior depending on the result
	_post_tick(agent, blackboard, result)
	
	# Notify completion and new state (i.e. the result of the execution)
	emit_signal("tick", result)
	
	if abort_tree:
		emit_signal("abort_tree")
	
	return result
