extends Container

# Individual Tables
# {<name>: [<quantity>, <buy_price>, <sell_price>], <enabled>}
# Group Tables
# <Name>: [<dict>, <enabled>]

func new_container(title):
	var c = GridContainer.new()
	var l1 = Label.new()
	c.set_columns(3)
	pass
