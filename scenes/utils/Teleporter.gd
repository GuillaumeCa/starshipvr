extends Spatial

func _on_Area_area_entered(area: Area) -> void:
	if "player" in area.name:
		var origin: Spatial = area.get_parent()
		origin.global_transform = $position.global_transform
