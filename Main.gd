extends Node3D

@onready var player = $Player

func _ready():
	GlobalVarsScript.levers_down = 0

func _physics_process(_delta):
	if GlobalVarsScript.levers_down == 10:
		pass
	pass
	#print(positions_list.pick_random())

func give_player_location():
	get_tree().call_group("enemies", "update_target_player", player.global_transform.origin)

