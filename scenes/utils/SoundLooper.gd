tool
extends AudioStreamPlayer3D

export var start_sound: AudioStream
export var mid_sound: AudioStream
export var end_sound: AudioStream

export var start: bool setget set_start
export var end: bool setget set_end

func set_start(val):
	start_loop()

func set_end(val):
	end_loop()

var state = "idle"

func start_loop():
	print("start")
	state = "start"
	stream = start_sound
	play()

func end_loop():
	print("end")
	state = "end"

func _on_SoundLooper_finished() -> void:
	print("state is: ", state)
	if state == "start":
		stream = mid_sound
		play()
		state = "mid"
	elif state == "mid":
		stream = mid_sound
		play()
	elif state == "end":
		stream = end_sound
		play()
		state = "idle"
	else:
		stream = null
		stop()
