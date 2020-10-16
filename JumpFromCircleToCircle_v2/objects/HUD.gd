extends CanvasLayer

func hide():
	$ScoreBox.hide()
	$DirectionContainer.hide()

func show():
	$ScoreBox.show()
	$DirectionContainer.show()

func update_score(value):
	$ScoreBox/ScoreContainer/Score.text = "Score: " + str(value)
	
func update_hiscore(value):
	$ScoreBox/HiScoreContainer/Hiscore.text = str(value)

func get_direction() -> int:
	return $DirectionContainer/Direction.get_frame()

func stop_animation():
	$DirectionContainer/Direction.stop()
	
func show_message(text):
	$Message.text = text
	$AnimationPlayer.play("show_message")
