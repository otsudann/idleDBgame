extends Node

const coin = preload("res://Scripts/Coin.gd")
onready var coins = coin.new()

## Tables and Values
# {<name>: [<quantity>, <buy_price>, <sell_price>], <enabled>}
var market = {"chocoCoins": [0, 0.1, 0.03, false], "beans": [0, 5, 5.05, false]}
var clothes = {"shirt": [0, 0.1, 0.03, false], "jeans": [0, 5, 5.05, false]}

## All elements
# <Name>: [<dict>, <enabled>]
var elements = {"Market":[market, false], "Clothes":[clothes, false]}

# Ex: upd_val(elements['Market'])
func update_values(element, name):
	element[name][0] += 1
	element[name][1] *= 0.05
	coins.coin_add += element[name][2]
