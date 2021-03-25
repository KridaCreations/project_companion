extends VBoxContainer

onready var new_card_button = $new_card_name


export  (NodePath) var demo_card_path setget set_path

var root
var last_position = Vector2(0,0)
var demo_card
var follow = false
var offset = Vector2(0,0)

func _ready():
	pass

func _physics_process(delta):
	if follow == true:
		_set_global_position(get_global_mouse_position() - offset)

func _on_new_card_name_text_entered(new_text):
	if new_text!= "" :
		var new_card = demo_card.duplicate()
		add_child_below_node($new_card_name,new_card)
		new_card.text = new_text
		new_card_button.text = "" 


func set_path(val):
	pass


func _on_detail_gui_input(event):
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
			root.list_container.move_child(self,self.get_index())
			root.child_focused = false
			root.focused_node = null
			last_position = get_global_position()
#			offset = get_global_mouse_position() - self.get_global_position()
			offset = Vector2(0,0)


