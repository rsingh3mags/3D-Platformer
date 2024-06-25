extends Node3D



func _on_area_3d_body_entered(body):
	if body ==$Player:
		get_tree().change_scene_to_file("res://scenes/level_2.tscn")
