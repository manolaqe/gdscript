extends CanvasLayer

onready var tween = $Tween

func appear():
	tween.interpolate_property(self, "offset:x", 1500, 0, 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()

func disappear():
	tween.interpolate_property(self, "offset:x", 0, 1500, 0.4, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	tween.start()
