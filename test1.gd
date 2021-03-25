extends Control

var follow = false
var offset = Vector2(0,0)

func _ready():
	pass


func _physics_process(delta):
	if follow == true:
		$ColorRect2._set_global_position(get_global_mouse_position() - offset)


func _on_ColorRect2_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed == true:
			follow = true
			offset = get_global_mouse_position() - $ColorRect2.get_global_position()
		elif event.pressed == false:
			follow = false


func _on_ColorRect_gui_input(event):
	print("here")
