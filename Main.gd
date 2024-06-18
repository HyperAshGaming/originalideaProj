extends Node3D

@onready var player = $Player


func _physics_process(_delta):
	pass
	#print(positions_list.pick_random())

func give_player_location():
	get_tree().call_group("enemies", "update_target_player", player.global_transform.origin)



