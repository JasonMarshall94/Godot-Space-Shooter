extends Area2D

@export var speed: int = 500

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, 'scale', Vector2(1,1), .1).from(Vector2(0,0))
	

func _process(delta: float) -> void:
	position.y -= speed * delta
