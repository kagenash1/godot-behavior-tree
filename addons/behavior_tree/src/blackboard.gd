class_name Blackboard, "res://addons/behavior_tree/icons/blackboard.svg"
extends Node

# This is the database where all your variables go. Here you keep track of
# whether the player is nearby, your health is low, there is a cover available,
# or whatever.
#
# You just store the data here and use it for condition checks in BTCondition scripts,
# or as arguments for your function calls in BTAction.
#
# This is a good way to separate data from behavior, which is essential
# to avoid nasty bugs.

export(Dictionary) var data: Dictionary

func _enter_tree() -> void:
	data = data.duplicate()

func _ready() -> void :
	for key in data.keys():
		assert(key is String, "Blackboard keys must be stored as strings.")

# Public: Updates or adds the blackboard with the provided key and value
#
# key = Contains the name the data will be stored upder in the blackboard
# value = Contains the data that will be associated with the key. (Variant)
# Example
#	set_data("health", 15)
func set_data(key: String, value) -> void:
	data[key] = value

# Public: Returns the blackboard data for the provided key
#
# key = Contains the name the data will be stored upder in the blackboard
#
# Example
#	get("health")
#		=> 15
#
# Returns Variant
func get_data(key: String):
	if data.has(key):
		var value = data[key]
		if value is NodePath:
			if value.is_empty() or not get_tree().get_root().has_node(value):
				data[key] = null
				return null
			else:
				return get_node(value) # If you store NodePaths, will return the Node.
		else:
			return value
	else:
		return null

# Public: Returns true if the key is present in the blackboard
#
# key = Contains the name the data will be stored upder in the blackboard
#
# Example
#	had_data("health")
#		=> true
func has_data(key: String) -> bool:
	return data.has(key)
