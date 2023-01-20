extends Node

## Individual Tables
# {<name>: [<quantity>, <buy_price>, <sell_price>], <enabled>}
var market = {"chocoCoins": [0, 0.1, 0.03, true], "beans": [0, 5, 1.0, false]}
var clothes = {"shirt": [0, 0.1, 0.03, false], "jeans": [0, 5, 1.0, false]}

## Group Tables
# <Name>: [<dict>, <enabled>]
var group = {"Market":[market, true], "Clothes":[clothes, false]}

# Ex: upd_val(group['Market'])
func update_values(group, coins):
	group[0] += 1
	group[1] *= 0.1
	coins.coin_add += group[2]
