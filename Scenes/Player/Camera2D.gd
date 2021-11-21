extends Camera2D


const MAX_ZOOM = 1.75
const MIN_ZOOM = 0.5
const ZOOM_INTERVAL = 0.125

var current_zoom = 1

func _input(event):
	if current:
		if event.is_action_pressed("zoom_in"):
			current_zoom = clamp(current_zoom - ZOOM_INTERVAL, MIN_ZOOM, MAX_ZOOM)
			zoom = Vector2(current_zoom, current_zoom)
		elif event.is_action_pressed("zoom_out"):
			current_zoom = clamp(current_zoom + ZOOM_INTERVAL, MIN_ZOOM, MAX_ZOOM)
			zoom = Vector2(current_zoom, current_zoom)
