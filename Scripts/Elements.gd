extends VBoxContainer

# Quantity / Sell / Buy
var fixed_attr = {"min_qtt": 15, "sell": 0.05, "buy": 0.25}
var dyn_attr = {"min_qtt": 15, "sell": 0.05, "buy": 0.25}
var mult_factor = {"qtt": 1.15, "sell": 1.3, "buy": 1.4}

## Names
var itemsArray = [
  ["apple", "apric", "avoca", "banan", "berry", "cherr", "cocon", "drago", "duria", "grape"],
  ["aspar", "bambo", "beetr", "brocc", "cabba", "carro", "cauli", "celer", "corns", "eggpl"],
]
var categsArray = ["fruit", "veggi"]
var fruitDict = {}
var veggiDict = {}
var categsItemsDict = {
  "fruit": fruitDict,
  "veggi": veggiDict,
 }

#this is a one time function to setup base sell/buy values 
func fill_dicts(build=true):
  if build:
    for categ in categsArray:
      for item in itemsArray[categsArray.find(categ, 0)]:
        categsItemsDict[categ][item] = {"min_qtt": dyn_attr["min_qtt"], "qtt": 0, "sell": dyn_attr["sell"], "buy": dyn_attr["buy"]}
        dyn_attr["min_qtt"] = stepify(dyn_attr["min_qtt"] * mult_factor["qtt"], 1)
        dyn_attr["buy"] = stepify(dyn_attr["buy"] * mult_factor["buy"], 0.01)
        dyn_attr["sell"] = stepify(dyn_attr["sell"] * mult_factor["sell"], 0.01)
        #print(dyn_attr["buy"])
    build = false

func check_min_qtt(categ, item, categContainer, signalTargetFile, categsItems):
  if categsItems[categ][item]["qtt"] >= categsItems[categ][item]["min_qtt"]:
    var categPosi = categsArray.find(categ, 0)
    var nextCategPosi = categPosi + 1
    var itemPosi = itemsArray[categPosi].find(item, 0)
    var nextItemPosi = itemPosi + 1
    if nextItemPosi > itemsArray[categPosi].size():
      categPosi += 1
      #print("min qtt 01", categsItems)
      build_categ_container(categsArray[nextCategPosi], itemsArray[nextCategPosi][0], categContainer, signalTargetFile, categsItems)
    else:
      #print("min qtt 02", categsItems)
      build_item(categ, itemsArray[categPosi][nextItemPosi], categContainer, signalTargetFile, categsItems)
    return true
  return false

func build_categ_container(categ, item, parentNode, signalTargetFile, categsItems):
  #print("build categs top", categsItems)
  if parentNode.get_node_or_null(categ) == null:
    var div = Label.new()
    div.name = "Divisory01"
    div.text = "------------------------------------------------------"
    div.set_align(1)
    parentNode.add_child(div)
    
    # Container
    var categContainer = GridContainer.new()
    categContainer.set_columns(5)
    categContainer.name = categ
    categContainer.set_size(Vector2(180,0))
    categContainer.size_flags_horizontal = 1
    parentNode.add_child(categContainer)

    var colName = Label.new()
    var colQtt = Label.new()
    var colSell = Label.new()
    var colBuy = Label.new()
    var colBuyBtns = Label.new()
    
    # Node Name (NOT VALUES)
    colName.name = categ
    colQtt.name = "Qtt"
    colSell.name = "SellPrice"
    colBuy.name = "BuyPrice"
    colBuyBtns.name = "BuyBtn"
    
    #Node Values
    colName.text = categ
    colName.uppercase = true
    colQtt.text = "qtt"
    colSell.text = "sel"
    colBuy.text = "buy"
    colBuyBtns.text = "+1"
    
    # Equally cell width
    colName.size_flags_horizontal = 2
    colQtt.size_flags_horizontal = 2
    colSell.size_flags_horizontal = 2
    colBuy.size_flags_horizontal = 2
    colBuyBtns.size_flags_horizontal = 2
    
    categContainer.add_child(colName)
    categContainer.add_child(colQtt)
    categContainer.add_child(colSell)
    categContainer.add_child(colBuy)
    categContainer.add_child(colBuyBtns)
    
    #print("build categs items 01", categsItems)
    build_item(categ, item, categContainer, signalTargetFile, categsItems)
  else:
    #print("build categs items 02", categsItems)
    build_item(categ, item, parentNode.get_node(categ), signalTargetFile, categsItems)

func build_item(categ, item, categContainer, signalTargetFile, categsItems):
  # categ == "fruit"
  # item == "apple"
  #print("item", categsItems)
  if categContainer.get_node_or_null(item) == null:
    
    var name = Label.new()
    var qtt = Label.new()
    var sell = Label.new()
    var buy = Label.new()
    var buyBtn = Label.new()

    name.name = item
    qtt.name = item + "Qtt"
    sell.name = item + "Sel"
    buy.name = item + "Buy"
    buyBtn.name = item + "BuyBtn"
    
    name.text = item
    qtt.text = str(categsItems[categ][item]["qtt"])
    sell.text = str(categsItems[categ][item]["sell"])
    buy.text = str(categsItems[categ][item]["buy"])
    buyBtn.text = "BUY"
    
    # Shape for the touch btn
    var rect_shape = RectangleShape2D.new()
    rect_shape.set_extents(Vector2(25, 7))
    
    # the touch btn
    var tsBtn = TouchScreenButton.new()
    tsBtn.name = item
    tsBtn.shape = rect_shape
    tsBtn.set_shape_centered(true)
    tsBtn.connect("released", signalTargetFile, "_on_Btn_click", [ categ, item, categsItems[categ][item], categContainer, categsItems ])
    buyBtn.add_child(tsBtn)
        
    categContainer.add_child(name)
    categContainer.add_child(qtt)
    categContainer.add_child(sell)
    categContainer.add_child(buy)
    categContainer.add_child(buyBtn)
  #print("build items")
    check_min_qtt(categ, item, categContainer, signalTargetFile, categsItems)
