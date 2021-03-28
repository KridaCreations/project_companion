extends Label

var root
var last_position = Vector2(0,0)
var follow = false
var offset = Vector2(0,0)
var blank_card 

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)

func _on_card_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed == true:
				follow = true
				root.card_focused = true
				root.focused_card = self
				last_position = get_global_position() 
				offset = get_global_mouse_position() - self.get_global_position()
		elif event.button_index == 2:
			root.load_line_editor(self)
			
