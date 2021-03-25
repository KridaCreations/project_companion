extends Label

var root
var last_position = Vector2(0,0)

var follow = false
var offset = Vector2(0,0)

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)
	
	


func _ready():
	pass


func _on_card_gui_input(event):
	#print("here")
	if event is InputEventMouseButton:
		if event.pressed == true:
			follow = true
			root.child_focused = true
			root.focused_node = self
			last_position = get_global_position()
			offset = get_global_mouse_position() - self.get_global_position()
		elif event.pressed == false:
			set_global_position(last_position)
			follow = false
			root.move_child(self,self.get_index())
			root.child_focused = false
			root.focused_node = null
			last_position = get_global_position()
			offset = Vector2(0,0)
