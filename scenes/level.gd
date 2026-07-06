extends Node2D

#1 Load the scene
var meteor_scene: PackedScene = load("res://scenes/meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

var health: int = 5
	
func _ready() -> void:
	# set initial health
	get_tree().call_group('ui', 'set_health', health)
	
	# stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $Stars.get_children():
		# position
		var step_size = 20
		var x_mult = size.x / step_size
		var y_mult = size.y / step_size
		
		var random_x = rng.randi_range(0, step_size) * x_mult
		var random_y = rng.randi_range(0, step_size) * y_mult
		star.position = Vector2(random_x, random_y)
		
		# scale
		var random_scale = rng.randf_range(0.5, 2)
		star.scale = Vector2(random_scale, random_scale)
		
		# speed
		star.speed_scale = rng.randf_range(0.6, 1.4)

func _on_meteor_timer_timeout() -> void:
	#2. create an instance
	var meteor = meteor_scene.instantiate()
	
	#3. attatch the node to the scene tree
	$Meteors.add_child(meteor)
	
	# connect the signal
	meteor.connect('collision', _on_meteor_collision)
	

func _on_meteor_collision():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	if health <= 0:
		get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")
	$Player._play_damage_sound()
	


func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos
