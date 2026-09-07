extends Node
class_name Level

signal xp_changed
signal increase_amt_changed

var xp: int = 0:
	set(value):
		xp = value
		xp_changed.emit()
		
		_update_ui()

var increase_amt: int = 1:
	set(value):
		increase_amt = value
		increase_amt_changed.emit()
		
		_update_ui()

@export_group("Action")
@export var work_btn: Button
@export var xp_label: Label
@export var increase_amt_label: Label


func _enter_tree() -> void:
	Global.level = self


func _exit_tree() -> void:
	Global.level = null


func _ready() -> void:
	work_btn.pressed.connect(_on_work_btn_pressed)


func _on_work_btn_pressed() -> void:
	xp += increase_amt


func _update_ui() -> void:
	xp_label.text = "%s XP" % xp
	increase_amt_label.text = "Increase Amount: %s" % increase_amt


func gain_increase_amt(cost: int) -> void:
	xp -= cost
	increase_amt += 1
