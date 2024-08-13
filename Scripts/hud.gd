extends CanvasLayer

func level(num):
	$CurrentLevel.text = "Level: " + str(num)

func coins(num):
	$CoinsLabel.text = "Coins: " + str(num)

func _process(_delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
