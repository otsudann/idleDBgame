extends VBoxContainer

# Quantity / Sell / Buy
var base_fixed_attr = {"min_qtt": 15, "sell": 0.03, "buy": 0.25}
var base_dynamic_attr = {"min_qtt": 15, "sell": 0.03, "buy": 0.25}
var multiplier_factor = {"qtt": 1.15, "sell": 1.6, "buy": 1.8}

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
var groups = {
  "fruit": [true, fruits_dict],
  "veggi": [false, veggies_dict],
 }

# Ex: upd_val(group['Market'])
func buy(element, coins):
  # Test if can buy
  if coins.buy(element["buy"]):
    # Increase Quantity
    element["qtt"] += 1
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
      groups[all][1][sub] = {"min_qtt": base_dynamic_attr["min_qtt"], "qtt": 0, "sell": base_dynamic_attr["sell"], "buy": base_dynamic_attr["buy"]}
      base_dynamic_attr["min_qtt"] = stepify(base_dynamic_attr["min_qtt"] * multiplier_factor["qtt"], 0.01)
      base_dynamic_attr["buy"] = stepify(base_dynamic_attr["buy"] * multiplier_factor["buy"], 0.01)
      base_dynamic_attr["sell"] = stepify(base_dynamic_attr["sell"] * multiplier_factor["sell"], 0.01)
  else:
    pass

func build_container(group, parent, target):
  for g in group:
    if group[g][0]:
      var div = Label.new()
      div.name = "Divisory01"
      div.text = "---------------------------------------------------------------"
      parent.add_child(div)
      
      #build group container
      var c = GridContainer.new()
      c.set_columns(5)
      c.name = g
      c.set_size(Vector2(180,0))
      c.size_flags_horizontal = 1
      parent.add_child(c)

      var l0 = Label.new()
      var l1 = Label.new()
      var l2 = Label.new()
      var l3 = Label.new()
      var l4 = Label.new()
      
      # Node Name (NOT VALUES)
      l0.name = g
      l1.name = "Amount"
      l2.name = "SellPrice"
      l3.name = "BuyPrice"
      l4.name = "BuyBtn"
      
      #Node Values
      l0.text = g
      l0.uppercase = true
      l1.text = "amo"
      l2.text = "sel"
      l3.text = "buy"
      l4.text = "+1"
      
      # Equally cell width
      l0.size_flags_horizontal = 2
      l1.size_flags_horizontal = 2
      l2.size_flags_horizontal = 2
      l3.size_flags_horizontal = 2
      l4.size_flags_horizontal = 2
      
      c.add_child(l0)
      c.add_child(l1)
      c.add_child(l2)
      c.add_child(l3)
      c.add_child(l4)
      
      #name_group, dict_group, container, target
      build_subcontainer(g, group[g][1], c, target)
    else:
      break


func build_subcontainer(g, subgroup, container, target):
  var c = container
  for el in subgroup:
    if subgroup[el]["qtt"] >= subgroup[el]["min_qtt"] or el == "apple":
      var el0 = Label.new()
      var el1 = Label.new()
      var el2 = Label.new()
      var el3 = Label.new()
      var el4 = Label.new()
  
      el0.name = el
      el1.name = el + "Qtt"
      el2.name = el + "Sel"
      el3.name = el + "Buy"
      el4.name = el + "BuyBtn"
      
      el0.text = el
      el1.text = str(subgroup[el]["qtt"])
      el2.text = str(subgroup[el]["sell"])
      el3.text = str(subgroup[el]["buy"])
      el4.text = "BUY"
      
      var ts = TouchScreenButton.new()
      ts.name = el
      var rect_shape = RectangleShape2D.new()
      rect_shape.set_extents(Vector2(25, 7))
      ts.shape = rect_shape
      ts.set_shape_centered(true)
      ts.connect("released", target, "_on_Btn_click", [ g, el])
      el4.add_child(ts)
          
      c.add_child(el0)
      c.add_child(el1)
      c.add_child(el2)
      c.add_child(el3)
      c.add_child(el4)
    else:
      break
