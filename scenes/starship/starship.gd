extends Spatial

enum StarshipType {
	TANKER,
	CREW,
	CARGO,
	LUNAR,
}

onready var chairs = $chairs
onready var cam_viewport = $cameras

export(StarshipType) var type = StarshipType.TANKER setget _set_type

var is_launching = false

# handle external door opening animation
var ext_door_open = false
var ext_door_opening = false

func _ready() -> void:
	if not Engine.editor_hint:
		return
	
	for chair in chairs.get_children():
		chair.starship = self
		chair.init_ui()
		
	init_type()

func _process(delta: float) -> void:
	if not Engine.editor_hint:
		return
	
	for chair in chairs.get_children():
		chair.gimbal = is_launching

func _set_type(new_type):
	type = new_type
	if Engine.editor_hint:
		init_type()

func init_type():
	match (type):
		StarshipType.TANKER:
			$body_no_window.visible = true
			$body_windows.visible = false
			
			$window_top_mesh.visible = false
			$window_mesh.visible = false
			$ext_door_frame.visible = false
			$ext_door_panel.visible = false
			
			$starship_interior.visible = false
		StarshipType.CREW:
			$body_no_window.visible = false
			$body_windows.visible = true
			
			$window_top_mesh.visible = true
			$window_mesh.visible = true
			$ext_door_frame.visible = true
			$ext_door_panel.visible = true
			
			$starship_interior.visible = true

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
	$plume/raptor_plume.toggle_emit(on)


func on_enter_starship():
	$starship_interior/ReflectionProbes.visible = true

func on_exit_starship():
	$starship_interior/ReflectionProbes.visible = false

func _on_ExtDoorBtn_button_pressed() -> void:
	if ext_door_opening:
		return
	ext_door_opening = true
	ext_door_open = !ext_door_open
	
	$starship_interior/ExtDoorBtn.set_active(true)
	
	if ext_door_open:
		$AnimationPlayer.play("open_ext_door")
	else:
		$AnimationPlayer.play_backwards("open_ext_door")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "open_ext_door":
		ext_door_opening = false
		$starship_interior/ExtDoorBtn.set_active(false)
