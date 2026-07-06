extends CharacterBody2D

@export var speed := 500

signal laser(pos)

var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size := get_viewport().get_visible_rect().size
	var initial_x = size.x / 2
	var initial_y = size.y / 2
	
	position = Vector2(initial_x, initial_y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# shoot input
	if Input.is_action_just_pressed("shoot") and can_shoot:
		laser.emit($LaserStartPos.global_position)
		can_shoot = false
		$LaserTimer.start()
		$LaserSound.play()
		

func _play_damage_sound() -> void:
	$DamageSound.play()


func _on_laser_timer_timeout() -> void:
	can_shoot = true
