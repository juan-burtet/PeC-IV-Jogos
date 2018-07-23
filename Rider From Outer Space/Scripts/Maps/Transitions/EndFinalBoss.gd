extends Node

export(String, FILE, "*.tscn") var next_world

const DIALOG_SCENE = preload("res://Scenes/Dialog/Dialog.tscn")

const TEXT8 = "NOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO!"
const TEXT9 = "THE GEM IS SAFE..."
const TEXT10 = "...FOR NOW."

var yellow = Color(1,1,0,1)
var red = Color(1, 0, 0, 1)
var green = Color(0,1,0,1)
var blue = Color(0,0,1,1)
var purple = Color(1,0,1,1)

var dialog

signal acabou
signal apertou

func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("apertou")
	pass


func _ready():
	dialog = DIALOG_SCENE.instance()
	self.add_child(dialog)
	$Timer.set_wait_time(0.5)
	$Timer.start()
	yield($Timer,"timeout")
	cria_dialogo("CARMACK", purple, TEXT8)
	$Timer.set_wait_time(0.5)
	$Timer.start()
	yield($Timer,"timeout")
	yield(self, "acabou")
	$Timer.set_wait_time(0.5)
	$Timer.start()
	yield($Timer,"timeout")
	cria_dialogo("RIDER", yellow, TEXT9)
	$Timer.set_wait_time(0.5)
	$Timer.start()
	yield($Timer,"timeout")
	yield(self, "acabou")
	$Timer.set_wait_time(0.5)
	$Timer.start()
	yield($Timer,"timeout")
	cria_dialogo("RIDER", yellow, TEXT10)
	$Timer.set_wait_time(0.5)
	$Timer.start()
	yield($Timer,"timeout")
	yield(self, "acabou")
	
	get_tree().change_scene(next_world)
	pass

func cria_dialogo(name, color, text):
	dialog.init(name,color,text)
	dialog.get_node("Animation").play("fade_in")
	yield(dialog.get_node("Animation"), "animation_finished")
	yield(self, "apertou")
	dialog.get_node("Animation").play("fade_out")
	yield(dialog.get_node("Animation"), "animation_finished")
	emit_signal("acabou")