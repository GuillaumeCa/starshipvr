extends Spatial

var target = 90

func _process(delta: float) -> void:
	pass
	#var rot = $support.rotation_degrees.x
#	if target == 0 and rot <= 0:
#		target = 90
#	elif target == 90 and rot >= 90:
#		target = 0
#
#	prints(rot, target)
#
#	if rot > target:
#		$support.rotation_degrees.x -= 1
#	else:
#		$support.rotation_degrees.x += 1
#
#	$support.rotation_degrees.z += 1
#	$support.rotation_degrees.y += 1
