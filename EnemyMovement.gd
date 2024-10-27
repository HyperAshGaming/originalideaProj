extends CharacterBody3D

@onready var nav_agent = $EnemyNPC/NavigationAgent3D
@onready var enemy_constant_sound = $EnemyConstantSound
@onready var enemy_anims = $EnemyNPC/EnemyAnimations
@onready var timer_audio_constant = $Timer

func _ready():
	axis_lock_linear_x = true
	axis_lock_linear_y = true
	axis_lock_linear_z = true
	
var SPEED = 20.0
var NewTargetAllowed = true

var radius = 1

func _physics_process(_delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * SPEED
	velocity = new_velocity
	move_and_slide()
	
func enemy_wander(wander_location):
	nav_agent.target_position = wander_location

func update_target_player(target_location):
	nav_agent.target_position = target_location

func _on_timer_timeout():
	axis_lock_linear_x = false
	axis_lock_linear_y = false
	axis_lock_linear_z = false
	_play_enemy_sound_constant()
	

func _play_enemy_sound_constant():
	enemy_constant_sound.pitch_scale = randf_range(0.8,1.2)
	enemy_constant_sound.play()
	timer_audio_constant.start()
