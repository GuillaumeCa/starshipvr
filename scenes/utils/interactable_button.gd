extends Spatial

export(SpatialMaterial) var default_material 
export(SpatialMaterial) var active_material

signal button_pressed

var is_active = false

var hand: OQ_ARVRController
var target_pos = 0

onready var area = $Area

func set_active(_active):
	is_active = _active

func _process(delta: float) -> void:
	if is_active:
		$Area/MeshInstance.set_surface_material(0, active_material)
		target_pos = -0.01
	else:
		$Area/MeshInstance.set_surface_material(0, default_material)
		target_pos = 0
		
	$Area/MeshInstance.translation.z = lerp($Area/MeshInstance.translation.z, target_pos, 0.2)

func _on_Area_area_entered(area: Area) -> void:
	if area is HandArea:
		emit_signal("button_pressed")
		hand = area.get_parent()
		hand.simple_rumble(0.2, 0.2)

func _on_Area_area_exited(area: Area) -> void:
	if area is HandArea:
		hand = null
