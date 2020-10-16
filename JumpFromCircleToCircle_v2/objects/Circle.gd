extends Area2D

var radius : float
var shrink_speed = 10

func calculate_radius(difficulty_level : float) -> float:
	var rand = randi() % 10 + 1
	radius = difficulty_level * rand * 10
	return radius

func init(_position):
	position = _position
	randomize()
	radius = 135
	var img_size = $Sprite.texture.get_size().x / 2
	$CollisionShape2D.shape = $CollisionShape2D.shape.duplicate()
	$CollisionShape2D.shape.radius *= radius/img_size
	return position
	
func capture():
	$AnimationPlayer.play("color_change")
	

func _physics_process(delta):
	radius = $CollisionShape2D.shape.radius
	var img_size = $Sprite.texture.get_size().x / 2 
	$CollisionShape2D.shape.radius -= shrink_speed * delta
	if $CollisionShape2D.shape.radius < 0.0:
		queue_free()
	else:
		$Sprite.scale = Vector2(1,1) * radius / img_size

func stop():
	shrink_speed = 0
	queue_free()
