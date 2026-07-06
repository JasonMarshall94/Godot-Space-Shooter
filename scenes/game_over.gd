extends Control

var level_scene: PackedScene = load("res://scenes/level.tscn")

func _ready():
	$CenterContainer/VBoxContainer/Score.text = "Your Score: " + str(Global.score)
	$GameOverMusic.play()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		get_tree().change_scene_to_packed(level_scene)
