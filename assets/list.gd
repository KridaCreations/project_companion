extends VBoxContainer

onready var new_card_button = $new_card_name

export  (NodePath) var demo_card_path setget set_path

var demo_card

func _ready():
	pass
	#demo_card = get_parent().get_parent().get_parent().get_node("card")


func _on_new_card_name_text_entered(new_text):
	if new_text!= "" :
		print("here")
		var new_card = demo_card.duplicate()
		add_child_below_node($new_card_name,new_card)
		#add_child(new_card)
		#new_card.set_owner(self) 
		new_card.text = new_text
		new_card_button.text = "" 


func set_path(val):
	pass
