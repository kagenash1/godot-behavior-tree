class_name BTNode, "icons/btnode.svg" 
extends Node

class BTNodeState:
	var success: bool = true  setget SetSuccess
	var failure: bool = false setget SetFailure
	var running: bool = false setget SetRunning
	
	func SetSuccess(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTState member. Use setters.")
			return
		success = true
		failure = false
		running = false
	func SetFailure(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTState member. Use setters.")
			return
		success = false
		failure = true
		running = false
	func SetRunning(value: bool = true):
		if value == false:
			print_debug("Ignoring manual change of BTState member. Use setters.")
			return
		success = false
		failure = false
		running = true
	func Equals(rhs: BTNodeState):
		if rhs.success:
			SetSuccess()
		elif rhs.failure:
			SetFailure()
		else:
			SetRunning()

export(bool) var isActive = true
export(bool) var debug = false
var state: BTNodeState = BTNodeState.new()
var fresh: bool = true

signal tick(result)

func Succeed():
	state.SetSuccess()
	emit_signal("tick", true)
func Fail():
	state.SetFailure()
	emit_signal("tick", false)
func Run():
	state.SetRunning()
func Succeeded():
	return state.success
func Failed():
	return state.failure
func Running():
	return state.running

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func Tick(agent: Node, blackboard: Blackboard):
	if not isActive or Running():
		return
	if fresh == true:
		fresh = false
	if debug:
		print(name)

func _ready():
	if isActive:
		Succeed()
	else:
		push_warning(name + ", ID: " + get_path() + " was deactivated.")
		Fail()
