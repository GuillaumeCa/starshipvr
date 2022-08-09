extends Spatial

func start_engine():
	$EngineSound.play()
	$booster_mesh/exterior_engines.toggle_emit(true)
	$booster_mesh/interior_engines.toggle_emit(true)

func stop_engine():
	$EngineSound.stop()
	$booster_mesh/exterior_engines.toggle_emit(false)
	$booster_mesh/interior_engines.toggle_emit(false)
	
func start_center():
	$EngineSound.play()
	$booster_mesh/exterior_engines.toggle_emit(false)
	$booster_mesh/interior_engines.toggle_emit(true)

func start_venting():
	for vent in $booster_mesh/venting.get_children():
		vent.emitting = true

func stop_venting():
	for vent in $booster_mesh/venting.get_children():
		vent.emitting = false
