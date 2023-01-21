extends Node

## Individual Tables
# {<name>: [<enabled>, <quantity>, <sell_price>, <buy_price>]}
var market = {"apples": [true, 0, 0.03, 0.1], "beans": [false, 0, 1.0, 5]}
var clothes = {"shirt": [false, 0, 0.03, 0.1], "jeans": [false, 0, 1.0, 5]}

## Group Tables
# <Name>: [<dict>, <enabled>]
var group = {"Market":[true, market], "Clothes":[false, clothes]}

# Ex: upd_val(group['Market'])
func update_values(element, coins):
  element[1] += 1
  element[2] *= 0.1
  coins.coin_add += element[3]
