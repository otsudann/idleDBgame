extends VBoxContainer

# Individual Tables
# {<name>: [<quantity>, <buy_price>, <sell_price>], <enabled>}
# Group Tables
# <Name>: [<dict>, <enabled>]

func build_container(group, parent):
  for g in group:
    if group[g][0]:
      #print(g)
      #build group container
      var c = GridContainer.new()
      c.set_columns(4)
      c.name = g
      c.set_size(Vector2(180,0))
      parent.add_child(c)
      var l0 = Label.new()
      var l1 = Label.new()
      var l2 = Label.new()
      var l3 = Label.new()
      l0.name = "+ " + g
      l0.text = "+ " + g
      l1.name = "Amount"
      l1.text = "A"
      l2.name = "SellPrice"
      l2.text = "S"
      l3.name = "BuyPrice"
      l3.text = "B"
      c.add_child(l0)
      c.add_child(l1)
      c.add_child(l2)
      c.add_child(l3)
      
      var subgroup = group[g][1]
      #print(subgroup)
      for el in subgroup:
        if subgroup[el][0]:
          var el0 = Label.new()
          var el1 = Label.new()
          var el2 = Label.new()
          var el3 = Label.new()
          el0.name = "--" + el
          el0.text = "--" + el
          el1.name = "ItemAmount"
          el1.text = str(subgroup[el][1])
          el2.name = "ItemSellPrice"
          el2.text = str(subgroup[el][2])
          el3.name = "ItemBuyPrice"
          el3.text = str(subgroup[el][3])
          c.add_child(el0)
          c.add_child(el1)
          c.add_child(el2)
          c.add_child(el3)
          print(subgroup[el])
