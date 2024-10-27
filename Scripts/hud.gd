extends CanvasLayer
# Show what level the player is on in the HUD
func level(num):
	$CurrentLevel.text = "Level: " + str(num)


# Show the amount of coin boosters that the player has collected
func coins(num):
	$CoinsLabel.text = "Booster: " + str(num)


# Show fps and the fastest time
func _process(_delta):
	$FPS.text = "FPS: " + str(Engine.get_frames_per_second())
	$BestTime.text = str(Global.fastest_time).pad_decimals(1) + " s"
