extends BoxContainer
class_name Skill

@export_group("Stats")
@export var skill_name: String = "No Idea"
@export var cost: int = 10
@export var cost_increase_amt: int = 10

@export_group("UI")
@export var purchase_btn: Button
@export var cost_label: Label


func _ready() -> void:
	Global.level.xp_changed.connect(_on_xp_changed)
	purchase_btn.pressed.connect(_on_purchase_btn_pressed)
	
	_update_ui()


func _on_xp_changed() -> void:
	_update_ui()


func _on_purchase_btn_pressed() -> void:
	Global.level.gain_increase_amt(cost)
	cost += cost_increase_amt
	
	_update_ui()


func _update_ui() -> void:
	purchase_btn.disabled = cost > Global.level.xp
	purchase_btn.text = skill_name
	cost_label.text = "Purchase for %s XP" % [cost]
