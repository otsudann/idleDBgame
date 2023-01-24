extends VBoxContainer

# Individual Tables
# {<name>: [<quantity>, <buy_price>, <sell_price>], <enabled>}
# Group Tables
# <Name>: [<dict>, <enabled>]

var last_element

func build_container(group, parent):
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
      
      var subgroup = group[g][1]
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
              
          c.add_child(el0)
          c.add_child(el1)
          c.add_child(el2)
          c.add_child(el3)
          c.add_child(el4)
          #print(subgroup[el])
