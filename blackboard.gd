class_name Blackboard, "icons/blackboard.svg" 
extends Node

export(Dictionary) var _data: Dictionary
var data: Dictionary

func _enter_tree():
	data = _data.duplicate()

func _ready():
	for key in data.keys():
		assert(key is String)

func SetData(key: String, value):
	if data.has(key):
		data[key] = value

func GetData(key: String):
	if data.has(key):
		var value = data[key]
		if value is NodePath:
			if value.is_empty() or not get_tree().get_root().has_node(value):
				data[key] = null
				return null 
			else:
				return get_node(value)
		else:
			return value

func HasData(key: String):
	return data.has(key)

