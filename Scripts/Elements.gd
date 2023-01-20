extends Node

const coin = preload("res://Scripts/Coin.gd")
onready var coins = coin.new()

## Tables and Values
# {<name>: [<quantity>, <buy_price>, <sell_price>]}
var market = {"chocoCoins": [0, 0.1, 0.03], "beans": [0, 5, 5.05]}
var clothes = {"shirt": [0, 0.1, 0.03], "jeans": [0, 5, 5.05]}

# All elements
var elements = {"Market":market, "Clothes":clothes}

# Ex: upd_val(elements['Market'])
func update_values(element, name):
	element[name][0] += 1
	element[name][1] *= 0.05
	coins.coin_add += element[name][2]
