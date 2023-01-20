extends Node

## Individual Tables
# {<name>: [<enabled>, <quantity>, <buy_price>, <sell_price>]}
var market = {"chocoCoins": [true, 0, 0.1, 0.03], "beans": [false, 0, 5, 1.0]}
var clothes = {"shirt": [false, 0, 0.1, 0.03], "jeans": [false, 0, 5, 1.0]}

## Group Tables
# <Name>: [<dict>, <enabled>]
var group = {"Market":[true, market], "Clothes":[false, clothes]}

# Ex: upd_val(group['Market'])
func update_values(element, coins):
  element[1] += 1
  element[2] *= 0.1
  coins.coin_add += element[3]
