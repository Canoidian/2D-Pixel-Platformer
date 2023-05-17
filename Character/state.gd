extends Node

class_name State

@export var can_move : bool = true

var charcter : CharacterBody2D
var next_state : State

func state_input(_event : InputEvent):
	pass
	
func on_enter():
	pass
	
func on_exit():
	pass
