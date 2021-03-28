extends Button

var associated_scene : String


func _ready():
	pass



func open_scene():
	get_tree().change_scene(associated_scene)
