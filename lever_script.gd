extends Node3D

var lever_state = false
var levers_finished = 0
@onready var lever_animation = $"AnimationPlayer"

func _process(_delta):
	#print(lever_state,"LEVER STATE")
	if Input.is_action_pressed("leftclick") and lever_state == true:
		lever_animation.play("LeverDownAnimation")
		lever_state = false
		GlobalVarsScript.levers_down += 1
		print(GlobalVarsScript.levers_down,"LEVERS")
		
	if GlobalVarsScript.levers_down > 4:
		print("game end")
		get_tree().change_scene_to_file("res://WinScreen.tscn")

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		lever_state = true
		print(lever_state,"TRUE")

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		lever_state = false
		print(lever_state,"FALSE")
