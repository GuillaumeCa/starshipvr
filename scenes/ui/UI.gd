extends Spatial

var main

func _on_EnterStarship_pressed() -> void:
	main.enter_starship()
	hide()

func _on_Launch_pressed() -> void:
	main.launch()
	hide()

func _on_Reset_pressed() -> void:
	main.reset()
	hide()


func _on_TowerBase_pressed() -> void:
	main.tower_base()
	hide()


func _on_EnterSeat_pressed() -> void:
	main.enter_seat()
	hide()

func _on_Restart_pressed() -> void:
	get_tree().reload_current_scene()

