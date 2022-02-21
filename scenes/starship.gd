extends Spatial

onready var chairs = $chairs
onready var cam_viewport = $cameras

var is_launching = false

func _ready() -> void:
	for chair in chairs.get_children():
		chair.starship = self
		chair.init_ui()

func _process(delta: float) -> void:
	for chair in chairs.get_children():
		chair.gimbal = is_launching

func start_engine():
	$EngineSound.play()
	toggle_plume($plume, true)
	
func stop_engine():
	$EngineSound.stop()
	toggle_plume($plume, false)

func get_cameras_viewport():
	return cam_viewport
	
func get_cameras():
	return $cameras/Spatial

func toggle_plume(node, on: bool):
	for flame in node.get_children():
		if flame.has_method("toggle_emit"):
			flame.toggle_emit(on)
