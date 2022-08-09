extends Spatial

var show_stats := false
var in_starship = false

var show_ui = false

onready var ui = $UI
onready var player = $player


func _ready():
	vr.initialize()
	ui.main = self


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		toggle_ui()
		
	if Input.is_action_just_pressed("ui_accept"):
		launch()
	
	if vr.button_just_pressed(vr.BUTTON.X):
		show_stats = !show_stats

	if show_stats:
		vr.show_dbg_info("FPS", Performance.get_monitor(Performance.TIME_FPS))
		vr.show_dbg_info("Objects", Performance.get_monitor(Performance.RENDER_OBJECTS_IN_FRAME))
		vr.show_dbg_info("Draw Calls", Performance.get_monitor(Performance.RENDER_DRAW_CALLS_IN_FRAME))
	
	if vr.button_just_pressed(vr.BUTTON.ENTER):
		toggle_ui()
	
	var animation_playing = $orbital_stand/AnimationPlayer.is_playing()
	player.get_node("Feature_Falling").active = !animation_playing or !in_starship
	$orbital_stand/starship.is_launching = $orbital_stand/AnimationPlayer.current_animation == "launch" and animation_playing

func _physics_process(delta: float) -> void:
	var camera_pos = vr.vrCamera.global_transform.origin
	# sync clouds position to player cam position
	$cloud_mesh.global_transform.origin.x = camera_pos.x
	$cloud_mesh.global_transform.origin.z = camera_pos.z

func toggle_ui():
	show_ui = !show_ui
	if show_ui:
		var target_transform = player.get_node("OQ_ARVRCamera/ui_position").global_transform
		ui.global_transform.origin = vr.vrCamera.global_transform.origin
		target_transform.origin.y = vr.vrCamera.global_transform.origin.y
		ui.look_at(target_transform.origin, Vector3.UP)
		ui.global_transform.origin = target_transform.origin
		ui.translate(Vector3(0, -1, 0))
	ui.visible = show_ui

func enter_starship():
	in_starship = true
	remove_child(player)
	$orbital_stand/starship.add_child(player)
	vr.vrOrigin.global_transform = $orbital_stand/starship/starship_entry.global_transform
	$orbital_stand/starship.on_enter_starship()
	
func enter_seat():
	in_starship = true
	remove_child(player)
	$orbital_stand/starship.add_child(player)
	vr.vrOrigin.global_transform = $orbital_stand/starship/starship_seat.global_transform
	$orbital_stand/starship.on_enter_starship()


func tower_base():
	in_starship = false
	$orbital_stand/starship.remove_child(player)
	add_child(player)
	vr.vrOrigin.global_transform = $tower_base.global_transform
	$orbital_stand/starship.on_exit_starship()

func launch():
	$orbital_stand/AnimationPlayer.play("launch")

func reset():
	$orbital_stand/AnimationPlayer.play("reset")

func retract_arm():
	$Tower/QDArm/QDAnimation.play_backwards("attach")

func deploy_arm():
	$Tower/QDArm/QDAnimation.play("attach")


func start_venting():
	$orbital_stand/booster.start_venting()

func stop_venting():
	$orbital_stand/booster.stop_venting()
	
func launch_exhaust():
	$orbital_stand/rocket_exhaust.emitting = true
	
func stop_exhaust():
	$orbital_stand/rocket_exhaust.emitting = false


