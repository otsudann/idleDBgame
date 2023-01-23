extends Node

# Quantity / Sell / Buy
var base_fixed_attr = {"quantity": 15, "sell": 0.03, "buy": 0.25}
var base_dynamic_attr = {"quantity": 15, "sell": 0.03, "buy": 0.25}
var multiplier_factor = {"quantity": 1.15, "sell": 1.6, "buy": 1.8}

## Names
var all_elements_list = {
  "fruit":  ["apple", "apric", "avoca", "banan", "berry", "cherr", "cocon", "drago", "duria", "grape"],
  "veggi":  ["aspar", "bambo", "beetr", "brocc", "cabba", "carro", "cauli", "celer", "corns", "eggpl"],
}

## Individual Tables
# {<name>: [<enabled>, <quantity>, <sell_price>, <buy_price>]}
var fruits_dict = {}
var veggies_dict = {}

## Group Tables
# <Name>: [<dict>, <enabled>]
var group = {
  "fruit": [true, fruits_dict],
  "veggi": [false, veggies_dict],
 }

# Ex: upd_val(group['Market'])
func buy(element, coins, container):
  # Test if can buy
  if coins.buy(element["buy"]):
    # Increase Quantity
    element["quantity"] += 1
    # Increase Buy Price
    element["buy"] *= 0.1
    # Update coin per second value
    coins.coin_add += element["sell"]
    
    # Must check if reach min quantity, enable the next

#this is a one time function to setup base sell/buy values 
func fill_dicts(check):
  if check:
   for all in all_elements_list:
    for sub in all_elements_list[all]:
      group[all][1][sub] = {"min_qtt": base_dynamic_attr["quantity"], "quantity": 0, "sell": base_dynamic_attr["sell"], "buy": base_dynamic_attr["buy"]}
      base_dynamic_attr["quantity"] = stepify(base_dynamic_attr["quantity"]*multiplier_factor["quantity"], 0.01)
      base_dynamic_attr["buy"] = stepify(base_dynamic_attr["buy"]*multiplier_factor["buy"], 0.01)
      base_dynamic_attr["sell"] = stepify(base_dynamic_attr["sell"]*multiplier_factor["sell"], 0.01)
  else:
    pass
  for l in group:
    print(group[l])
