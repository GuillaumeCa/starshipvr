tool
extends Spatial

export var arm_rotation := 0.0 setget _set_arm_rotation
export var arm_open_angle := 0.0 setget _set_arm_open_angle
export var arm_height := 0.0 setget _set_arm_height
export var catch_position := 0.0 setget _set_catch_position

var init_base_rotation = -45.0
var init_arm_height = 10.0
var init_catch_position = 10.3

var arm_attached := false

func _process(delta: float) -> void:
	if Engine.editor_hint:
		pass
		#var pos = _compute_closest_position($MeshInstance)
		#$arms_support/pivot/catch_position.translation = pos

func _set_arm_rotation(new_rotation):
	arm_rotation = new_rotation
	_rotate_arm()

func _set_arm_open_angle(new_angle):
	arm_open_angle = new_angle
	_rotate_arm()
	
func _set_arm_height(new_height):
	arm_height = new_height
	$arms_support.translation.y = init_arm_height + arm_height

func _set_catch_position(new_pos):
	catch_position = new_pos
	$arms_support/pivot/catch_position.translation.x = init_catch_position + catch_position
	$arms_support/pivot/catch_position.translation.z = -(init_catch_position + catch_position)

func _rotate_arm():
	$arms_support/arm_mesh_left.rotation_degrees.y = init_base_rotation + arm_open_angle + arm_rotation
	$arms_support/arm_mesh_right.rotation_degrees.y = init_base_rotation - arm_open_angle + arm_rotation
	$arms_support/pivot.rotation_degrees.y = arm_rotation

func _compute_closest_position(container: Spatial) -> Vector3:
	var catch_pos = $arms_support/pivot/catch_position
	var d = container.global_translation - catch_pos.global_translation
	var direction = catch_pos.transform.rotated(Vector3(0, 1, 0), deg2rad(-45)).basis.x
	$arms_support/pivot/catch_position/DirDebug.translation = direction
	return catch_pos.transform.xform(d).project(direction)

func _on_ArmArea_area_entered(area: Area) -> void:
	if not arm_attached:
		arm_attached = true
		if area.has_method("get_container"):
			$arms_support/pivot/catch_position/RemoteTransform.remote_path = area.get_container().get_path()

func _on_ArmArea_area_exited(area: Area) -> void:
	if arm_attached:
		arm_attached = false
		$arms_support/pivot/catch_position/RemoteTransform.remote_path = NodePath()
