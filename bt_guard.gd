class_name BTGuard, "icons/bt_guard.svg"
extends BTNode

export(bool) var startLocked = false
export(NodePath) var _locker
export(String, "Failure", "Success", "Always") var lockIf
export(NodePath) var _unlocker
export(int, "Failure", "Success") var unlockIf
export(float) var lockTime = get_physics_process_delta_time()
var locked: bool = false
onready var unlocker: BTNode = get_node_or_null(_unlocker)
onready var locker: BTNode = get_node_or_null(_locker)
onready var btChild: BTNode = get_child(0) as BTNode

func CheckLock():
	if lockIf == "Always" or (Succeeded() and lockIf == "Success") or (Failed() and lockIf == "Failure"):
		Lock()

func Lock():
	locked = true
	if unlocker != null:
		while locked:
			var result = yield(unlocker, "tick")
			if result == bool(unlockIf):
				locked = false
	else:
		yield(get_tree().create_timer(lockTime), "timeout")
		locked = false

func Tick(agent: Node, blackboard: Blackboard):
	if not isActive or Running():
		return
	if locked:
		if not Failed():
			Fail()
		return
	if debug:
		print(name)
	if fresh == true:
		fresh = false
	var result = btChild.Tick(agent, blackboard)
	if btChild.Running() and result is GDScriptFunctionState:
		Run()
		yield(result, "completed")
	if locker == null:
		state.Equals(btChild.state)
		CheckLock()

func on_Locker_tick(_result):
	state.Equals(locker.state)
	CheckLock()

func _ready():
	assert(get_child_count() == 1)
	if startLocked:
		Lock()
	if locker != null:
		locker.connect("tick", self, "on_Locker_tick")
