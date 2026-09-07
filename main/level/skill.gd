extends BoxContainer
class_name Skill

@export_group("Stats")
@export var skill_id: String = "no_idea"
@export var skill_name: String = "No Idea"
@export var cost: int = 10
@export var cost_of_learning_upgrade: int = 10

@export_group("UI")
@export var purchase_btn: Button
@export var cost_label: Label


func _ready() -> void:
	Global.level.focus_changed.connect(_on_focus_changed)
	purchase_btn.pressed.connect(_on_purchase_btn_pressed)
	
	_update_ui()


func _on_focus_changed() -> void:
	_update_ui()


func _on_purchase_btn_pressed() -> void:
	Global.level.increase_learning_speed(cost)
	cost += cost_of_learning_upgrade
	
	_update_ui()
	
	DataManager.save_game()


func _update_ui() -> void:
	purchase_btn.disabled = cost > Global.level.focus
	purchase_btn.text = skill_name
	cost_label.text = "Purchase for %s Focus" % [cost]
