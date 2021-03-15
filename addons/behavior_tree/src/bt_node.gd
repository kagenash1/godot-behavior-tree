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


# Emitted after a tick() call. True is success, false is failure. Can be useful
# to get info on the state of other BTNodes
signal tick(result)

export(bool) var is_active = true # Turn this off to block a branch of the tree
export(bool) var debug = false # Turn this on to print the name of the BTNode

var state: BTNodeState = BTNodeState.new()


# Called after tick()
func _on_tick(result: bool):
	pass


# This is the most important function. Override this and put your behavior here.
func _tick(agent: Node, blackboard: Blackboard) -> bool:
	return succeed()


func _ready():
	if is_active:
		succeed()
	else:
		push_warning(name + ", ID: " + get_path() + " was deactivated.")
		fail()
	
	connect("tick", self, "_on_tick")


# You can use these as setters and getters for the BTNodeState of a BTNode
func succeed() -> bool:
	state.set_success()
	return true


func fail() -> bool:
	state.set_failure()
	return false


func run():
	state.set_running()


func succeeded() -> bool:
	return state.success


func failed() -> bool:
	return state.failure


func running() -> bool:
	return state.running


func get_state() -> String:
	if succeeded():
		return "success"
	elif failed():
		return "failure"
	else:
		return "running"


func set_state(rhs: BTNode) -> bool:
	if rhs.succeeded():
		return succeed()
	else:
		return fail()


# DO NOT override this
func tick(agent: Node, blackboard: Blackboard) -> bool:
	if not is_active:
		return fail()
	
	if running():
		return false
	
	if debug:
		print(name)
	
	run() 
	
	var result = _tick(agent, blackboard)
	
	if result is GDScriptFunctionState:
		assert(running())
		result = yield(result, "completed")
	
	assert(not running())
	
	emit_signal("tick", result)
	
	return result


