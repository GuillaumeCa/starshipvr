extends Spatial

export var gimbal = false
export var show_ui = false

var target_rot = 0

var starship

var current_cam_idx = 0

var is_player_inside = false

var ui_viewport_texture
var ui_label

onready var mesh = $chair001
onready var ui = $chair001/UI

func _ready() -> void:
	ui.visible = show_ui
	ui_viewport_texture = ui.ui_control.get_node("TextureRect")
	ui_label = ui.ui_control.get_node("Label")

func _process(delta: float) -> void:
	if gimbal:
		var amount = global_transform.basis.y.normalized().dot(Vector3.UP)
		amount = 1 - amount
		amount = clamp(amount, 0, 1)
		target_rot = ((1 - amount) * (-60 - 15)) + 15
	else:
		target_rot = 0
	
	if mesh:
		var rot = mesh.rotation_degrees
		rot.z = target_rot
		mesh.rotation_degrees = mesh.rotation_degrees.linear_interpolate(rot, 0.2)
	
	if vr.button_just_pressed(vr.BUTTON.A):
		var cam_viewport = starship.get_cameras() as Spatial
		current_cam_idx = (current_cam_idx + 1) % cam_viewport.get_child_count()
		update_ui()
	

func init_ui():
	update_ui()
	var cam_viewport = starship.get_cameras_viewport() as Viewport
	# set viewport_texture
	var tex = ui_viewport_texture.texture as ViewportTexture
	tex.viewport_path = cam_viewport.get_path()
	

func update_ui():
	var cams = starship.get_cameras() as Spatial
	# set active camera
	for i in range(cams.get_child_count()):
		cams.get_child(i).current = current_cam_idx == i
	
	ui_label.text = "Camera #" + str(current_cam_idx)

func _set_position(rotation = 0):
	target_rot = rotation

func reset():
	gimbal = false

func enter_seat():
	gimbal = true


func _on_EnterArea_area_entered(area: Area) -> void:
	is_player_inside = true

func _on_EnterArea_area_exited(area: Area) -> void:
	is_player_inside = false
