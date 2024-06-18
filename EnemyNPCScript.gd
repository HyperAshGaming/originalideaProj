extends Node3D

var last_pos_location
var h = 6
var positions_list = [Vector3(0,h,-340),Vector3(-340,h,-68),Vector3(0,6,68),Vector3(-84,h,272),Vector3(305,h,73)]
var new_random_target = true
var cooldown_wander = 5

#Cloning as original version moves around the map. (mode)

func _on_vision_timer_timeout():
	var overlaps = $VisionArea.get_overlapping_areas()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.name == "Player":
				var playerPosition = overlap.global_transform.origin
				$VisionRayCast.look_at(playerPosition, Vector3.UP)
				$VisionRayCast.force_raycast_update()
				
				if $VisionRayCast.is_colliding():
					var collider = $VisionRayCast.get_collider()
					if collider.name == "Player":
						$VisionRayCast.debug_shape_custom_color = Color(174,0,0)
						print("Chasing")
						get_tree().call_group("World", "give_player_location")
						if cooldown_wander != 5:
							cooldown_wander = 5
					elif collider.name != "Player":
						$VisionRayCast.debug_shape_custom_color = Color(0,255,0)
						if cooldown_wander == 0:
							print("Wandering")
							var pos_location = positions_list.pick_random()
							if pos_location != last_pos_location:
								get_tree().call_group("enemies", "enemy_wander", pos_location)
								last_pos_location = pos_location
						else:
							cooldown_wander_decrease()
	print(cooldown_wander)

func _on_navigation_agent_3d_target_reached():
	print("stop")

func cooldown_wander_decrease():
	if cooldown_wander != 0:
		cooldown_wander -= get_process_delta_time()*10
	elif cooldown_wander < 0:
		cooldown_wander = 0
	return cooldown_wander
