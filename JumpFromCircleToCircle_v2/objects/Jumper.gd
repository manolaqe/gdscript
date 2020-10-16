extends Area2D

signal captured
signal jumped
signal died

onready var trail = $Trail/Points
var trail_length = 100

var velocity = Vector2(0, 1000)
var jump_speed = 500
var target = null
var direction

func _ready():
	trail.clear_points()

func reset_player():
	$Sprite.set_rotation_degrees(0.0)
	$CollisionPolygon2D.set_rotation_degrees(0.0)

func set_direction(_direction):
	direction = _direction

func _unhandled_input(event):
	if target and event is InputEventScreenTouch and event.pressed:
		jump(direction)
		if Setings.enable_sound:
			$Beep.play()

func jump(direction : int):
	emit_signal("jumped", direction)
	target = null
		

	match (direction):
		0:
			velocity = transform.y * jump_speed # up jump
		1:
			$Sprite.rotate(-PI/4)
			$CollisionPolygon2D.rotate(-PI/4)
			velocity = transform.y.rotated(-PI/4) * jump_speed # up_left jump
		2:
			$Sprite.rotate(-PI/2)
			$CollisionPolygon2D.rotate(-PI/2)
			velocity = transform.y.rotated(-PI/2) * jump_speed # left jump
		3:
			$Sprite.rotate(-3*PI/4)
			$CollisionPolygon2D.rotate(-3*PI/4)
			velocity = transform.y.rotated(-3*PI/4)* jump_speed # down_left jump
		4:
			$Sprite.rotate(-PI)
			$CollisionPolygon2D.rotate(-PI)
			velocity = transform.y.rotated(-PI) * jump_speed # down jump
		5:
			$Sprite.rotate(-5*PI/4)
			$CollisionPolygon2D.rotate(-5*PI/4)
			velocity = transform.y.rotated(-5*PI/4) * jump_speed # down_right jump
		6:
			$Sprite.rotate(-3*PI/2)
			$CollisionPolygon2D.rotate(-3*PI/2)
			velocity = transform.y.rotated(-3*PI/2) * jump_speed # right jump
		7:
			$Sprite.rotate(-7*PI/4)
			$CollisionPolygon2D.rotate(-7*PI/4)
			velocity = transform.y.rotated(-7*PI/4)* jump_speed # up_right jump
	
func _on_Jumper_area_entered(area):
	target = area
	velocity = Vector2.ZERO
	emit_signal("captured", area)

func _on_Jumper_area_exited(area):
	if velocity == Vector2.ZERO:
		die()

func _physics_process(delta):
	if trail.points.size() > trail_length:
		trail.remove_point(0)
		trail.remove_point(1)
		trail.remove_point(2)
	trail.add_point(position)
	if target:
		transform = target.global_transform
	else:
		position -= velocity * delta

func die():
	target = null
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("died")
	die()
	
	
