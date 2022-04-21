class_name BehaviorTree, "res://addons/behavior_tree/icons/bt.svg"
extends Node

# This is your main node. Put one of these at the root of the scene and start adding BTNodes.
# A Behavior Tree only accepts ONE entry point (so one child).

export(bool) var is_active: bool = false
export(NodePath) var _blackboard
export(NodePath) var _agent
export(int, "Idle", "Physics") var sync_mode
export(bool) var debug = false

var tick_result

onready var agent = get_node(_agent) as Node
onready var blackboard = get_node(_blackboard) as Blackboard
onready var bt_root = get_child(0) as BTNode

func _ready() -> void:
	assert(get_child_count() == 1, "A Behavior Tree can only have one entry point.")
	bt_root.propagate_call("connect", ["abort_tree", self, "abort"])
	start()

func _process(_delta: float) -> void:
	if not is_active:
		set_process(false)
		return

	if debug:
		print()

	tick_result = bt_root.tick(agent, blackboard)

	if tick_result is GDScriptFunctionState:
		set_process(false)
		yield(tick_result, "completed")
		set_process(true)

func _physics_process(_delta: float) -> void:
	if not is_active:
		set_physics_process(false)
		return

	if debug:
		print()

	tick_result = bt_root.tick(agent, blackboard)

	if tick_result is GDScriptFunctionState:
		set_physics_process(false)
		yield(tick_result, "completed")
		set_physics_process(true)

# Internal: Set up if we are using process or physics_process for the behavior tree
func start() -> void:
	if not is_active:
		return

	match sync_mode:
		0:
			set_physics_process(false)
			set_process(true)
		1:
			set_process(false)
			set_physics_process(true)

# Public: Set the tree to inactive when a abort_tree signal is sent from bt_root
func abort() -> void:
	is_active = false
