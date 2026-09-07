extends Node
class_name Main


func _ready() -> void:
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://main/level/levels/lvl_01.tscn")
