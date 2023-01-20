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
      var l = Label.new()
      l.name = "+ " + g
      l.text = "+ " + g
      var l1 = Label.new()
      var l2 = Label.new()
      var l3 = Label.new()
      l1.name = "Amount"
      l1.text = "A"
      l2.name = "SellPrice"
      l2.text = "S"
      l3.name = "BuyPrice"
      l3.text = "B"
      c.add_child(l)
      c.add_child(l1)
      c.add_child(l2)
      c.add_child(l3)

      for el in group[g][1]:
        var l_el = Label.new()
        l_el.name = el
        l_el.text = el
        c.add_child(l_el)
