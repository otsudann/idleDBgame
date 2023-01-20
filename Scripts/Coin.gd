extends Node

var current_value = 0
var coin_add = 0.01

func add():
	current_value += coin_add

func show():
	return current_value
