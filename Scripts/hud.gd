extends CanvasLayer

func level(num):
	$CurrentLevel.text = "Level: " + str(num)

func coins(num):
	$CoinsLabel.text = "Booster: " + str(num)

func _process(_delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	#var best_time = Global.best_time
	$BestTime.text = str(Global.fastest_time).pad_decimals(1) + " s"

