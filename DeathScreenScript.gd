extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_quit_button_pressed():
	get_tree().quit()

func _on_retry_button_pressed():
	get_tree().change_scene_to_file("res://Main.tscn")


func _on_menu_button_pressed():
	get_tree().change_scene_to_file("res://MainMenu.tscn")