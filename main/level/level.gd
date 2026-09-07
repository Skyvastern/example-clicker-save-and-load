extends Node
class_name Level

var xp: int = 0
var increase_amt: int = 1

@export_group("Action")
@export var work_btn: Button
@export var xp_label: Label


func _ready() -> void:
	work_btn.pressed.connect(_on_work_btn_pressed)


func _on_work_btn_pressed() -> void:
	xp += increase_amt
	xp_label.text = str(xp) + " XP"
