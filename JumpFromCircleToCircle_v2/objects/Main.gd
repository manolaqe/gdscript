extends Node2D

var Jumper = preload("res://objects/Jumper.tscn")
var Circle = preload("res://objects/Circle.tscn")
var HUD = preload("res://objects/HUD.tscn")

var score


const UP = Vector2(270,-810)
const UP_LEFT =  Vector2(0, -810)
const LEFT =  Vector2(0, -540)
const DOWN_LEFT = Vector2(0, -270)
const DOWN =  Vector2(270,-270)
const DOWN_RIGHT = Vector2(540, -270)
const RIGHT =  Vector2(540, -540)
const UP_RIGHT =  Vector2(540,-810)
const MIDDLE = Vector2(270,-540)

const directions = [UP_LEFT, UP, UP_RIGHT, LEFT, MIDDLE, RIGHT, DOWN_LEFT, DOWN, DOWN_RIGHT]

var tronk = false
var switch = true
var player
var hud

func _ready():
	randomize()

func new_game():
	hud = HUD.instance()
	add_child(hud)
	hud.show()
	score = 0
	if Setings.hiscore != null:
		Setings.hiscore = max(score, Setings.hiscore)
	else:
		Setings.hiscore = score
	$StartPosition.set_position(Vector2(270, -270))
	$Camera2D.position = $StartPosition.position
	player = Jumper.instance()
	player.position = $StartPosition.position
	add_child(player)
	player.connect("captured", self, "_on_Jumper_captured")
	player.connect("jumped", self, "_on_Jumper_jumped")
	player.connect("died", self, "_on_Jumper_died")
	for i in range(directions.size()):
		var c = Circle.instance()
		add_child(c)
		c.init(directions[i])
	tronk = true
	hud.show_message("GO")

func _process(delta):
	if tronk:
		randomize()
		if(player != null):
			player.set_direction(hud.get_direction())
		else:
			hud.stop_animation()

func spawn_circle_square(_position, difficulty_level):
	randomize()
	var rand_upper = randi() % 3 
	var rand_middle = randi() % 3 + 3
	var rand_lower = randi() % 3 + 6
	if directions[rand_upper].y < 0.0:
		var d = Circle.instance()
		add_child(d)
		d.init(Vector2(directions[rand_upper].x ,directions[rand_upper].y + _position.y))
	if directions[rand_middle].y < 0.0:
		var c = Circle.instance()
		add_child(c)
		c.init(Vector2(directions[rand_middle].x ,directions[rand_middle].y + _position.y))
	if directions[rand_lower].y <= 0.0:
		var e = Circle.instance()
		add_child(e)
		e.init(Vector2(directions[rand_lower].x ,directions[rand_lower].y + _position.y))

func _on_Jumper_jumped(object):
	switch = true

func _on_Jumper_captured(object):
	object.capture()
	if int(object.get_position().y)% 810 == 0 and int(object.get_position().y) != 0 and switch == true:
		call_deferred("spawn_circle_square", object.get_position(), 3)
		switch = false
	score +=1
	hud.update_score(score)
	Setings.hiscore = max(Setings.hiscore, score)
	hud.update_hiscore(Setings.hiscore)
	$Camera2D.position.y = object.position.y
	player.reset_player()
	
func _on_Jumper_died():
	get_tree().call_group("circles", "stop")
	hud.hide()
	$Screens.game_over()
	

