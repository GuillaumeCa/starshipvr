extends Spatial

func start_engine():
	$EngineSound.play()
	toggle_plume($booster_mesh/center, true)
	toggle_plume($booster_mesh/exterior, true)

func stop_engine():
	$EngineSound.stop()
	toggle_plume($booster_mesh/center, false)
	toggle_plume($booster_mesh/exterior, false)
	
func start_center():
	$EngineSound.play()
	toggle_plume($booster_mesh/center, true)
	toggle_plume($booster_mesh/exterior, false)

func start_venting():
	for vent in $booster_mesh/venting.get_children():
		vent.emitting = true

func stop_venting():
	for vent in $booster_mesh/venting.get_children():
		vent.emitting = false

func toggle_plume(node, on: bool):
	for flame in node.get_children():
		if flame.has_method("toggle_emit"):
			flame.toggle_emit(on)
