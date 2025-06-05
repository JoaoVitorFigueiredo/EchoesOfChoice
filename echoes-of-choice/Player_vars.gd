extends Node


var max_health = 100
var health = 100

var speed =300
var karma = 50

var can_move = true

func change_karma(amount:int):
	karma += amount
