tool
extends Spatial

export var left = false setget _set_left

var trigger = 0.0
var grip = 0.0

func _set_left(value):
	left = value
	$Armature.scale.z = -1 if !left else 1 

func _ready() -> void:
	if !left:
		$Armature.scale.z = -1
		
func _get_axis(val):
	return (val + 1.0) / 2.0

func _process(delta: float) -> void:
	if Engine.editor_hint:
		return

	if left:
		grip = _get_axis(vr.get_controller_axis(vr.AXIS.LEFT_GRIP_TRIGGER))
		trigger = vr.button_pressed(vr.BUTTON.LEFT_TOUCH_INDEX_POINTING)
	else:
		grip = _get_axis(vr.get_controller_axis(vr.AXIS.RIGHT_GRIP_TRIGGER))
		trigger = vr.button_pressed(vr.BUTTON.RIGHT_TOUCH_INDEX_POINTING)
	
	var grip_blend = $AnimationTree.get("parameters/grip/blend_amount")
	set_grip(lerp(grip_blend, grip, 0.2))
	
	var trigger_blend = $AnimationTree.get("parameters/trigger/blend_amount")
	$AnimationTree.set("parameters/trigger/blend_amount", lerp(trigger_blend, trigger, 0.2))

func set_grip(val: float):
	$AnimationTree.set("parameters/grip/blend_amount", val)

func set_trigger(val: float):
	trigger = val
