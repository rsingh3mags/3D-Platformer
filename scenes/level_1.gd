extends Node3D



func _on_area_3d_body_entered(body):
	if body ==$Player:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")


func _on_coins_collected():
	$HUD/CoinsLabel.text = "Coins: " +  str(Global.coins_collected)
