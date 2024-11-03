extends Node3D

var lever_state = false
var levers_finished = 0
var lever_metadata
@onready var lever_animation = $"AnimationPlayer"

func _process(_delta):
	if Input.is_action_pressed("leftclick") and lever_state == true and lever_metadata != true:
		self.set_meta("Activated",true)
		lever_animation.play("LeverDownAnimation")
		lever_state = false
		GlobalVarsScript.levers_down += 1
		print(GlobalVarsScript.levers_down,"LEVERS")
		
	if GlobalVarsScript.levers_down > 4:
		print("game end")
		get_tree().change_scene_to_file("res://WinScreen.tscn")

func _on_area_3d_body_entered(body):
	lever_metadata = self.get_meta('Activated')
	if body.name == "Player":
		lever_state = true

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		lever_state = false