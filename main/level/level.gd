extends Node
class_name Level

signal focus_changed
signal learning_changed
signal xp_changed

var focus: int = 0:
	set(value):
		focus = value
		focus_changed.emit()
		
		_update_ui()

var learning: int = 1:
	set(value):
		learning = value
		learning_changed.emit()
		
		_update_ui()

var xp: int = 0:
	set(value):
		xp = value
		xp_changed.emit()
		
		_update_ui()

@export_group("Action")
@export var work_btn: Button
@export var focus_label: Label
@export var learning_label: Label
@export var xp_label: Label


func _enter_tree() -> void:
	Global.level = self


func _exit_tree() -> void:
	Global.level = null


func _ready() -> void:
	work_btn.pressed.connect(_on_work_btn_pressed)


func _on_work_btn_pressed() -> void:
	focus += learning
	xp += learning


func _update_ui() -> void:
	focus_label.text = "%s F" % focus
	learning_label.text = "Learning: %s Focus/Click" % learning
	xp_label.text = "Experience: %s" % xp


func increase_learning_speed(cost: int) -> void:
	focus -= cost
	learning += 1
