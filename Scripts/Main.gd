extends Control

const c = preload("res://Scripts/Coin.gd")
const svLd = preload("res://Scripts/SaveLoad.gd")
const elem = preload("res://Scripts/Elements.gd")

var parent
var coinPriceLabel
var coinsPerSec
var touchQttLabel

var coins = c.new()
var saveLoad = svLd.new()
var elementsScript = elem.new()
var categsItemsDict = elementsScript.categsItemsDict
var time = 0
var timeLimit1 = 1
var timeLimit5 = 5
var timeSave = 0
var one_time_build = true

# Called when the node enters the scene tree for the first time.
func _ready():
  elementsScript.fill_dicts()
  #print("ready 00", categsItemsDict)
  # Load data
  print(categsItemsDict)
  saveLoad.loadGame(coins.coin, categsItemsDict)
  coins.coin = saveLoad.game_data.coins
  categsItemsDict = saveLoad.game_data.categsItems
  
  parent = get_node("MainScrollContainer/MainVBoxContainer")
  # show coins
  parent.get_node("Coins").text = coins.show()
  parent.get_node("CoinsPerSec").text = coins.show_coins_per_sec()
  parent.get_node("CoinUpgrade/CoinUpgQtt").text = str(coins.coin["touchCoinQtt"])
  parent.get_node("CoinUpgrade/BuyPrice").text = "$" + str(stepify(coins.coin["touchBuyPrice"], 0.01))
  
  #print("ready 01", categsItemsDict)
  # build containers
  elementsScript.build_categ_container("fruit", "apple", parent, self, categsItemsDict)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    
  # Make things happen EACH SECOND
  time += delta
  if time >= timeLimit1:
    coins.add()
    # Show current coins
    parent.get_node("Coins").text = coins.show()
    parent.get_node("CoinsPerSec").text = coins.show_coins_per_sec()
    time = 0
  
  # Make things happen EACH 5 SECONDS
  timeSave += delta
  if timeSave >= timeLimit5:
    saveLoad.saveGame(coins.coin, categsItemsDict)
    timeSave = 0

func _on_AddCoin_pressed():
  coins.touch_add()
  parent.get_node("Coins").text = coins.show()

func _on_TouchUpgCoin_pressed():
  if coins.buy(coins.coin["touchBuyPrice"], coins.coin["touchSellPrice"]):
    coins.touch_upg()
    parent.get_node("CoinUpgrade/BuyPrice").text = "$" + str(stepify(coins.coin["touchBuyPrice"], 0.01))
    parent.get_node("CoinUpgrade/CoinUpgQtt").text = str(coins.coin["touchCoinQtt"])
    parent.get_node("Coins").text = coins.show()
    parent.get_node("CoinsPerSec").text = coins.show_coins_per_sec()

func _on_Btn_click(categ, item, itemAttr, container, categsItems):
  if coins.buy(itemAttr["buy"], itemAttr["sell"]):
    categsItems[categ][item]["qtt"] += 1
    categsItems[categ][item]["buy"] = stepify(categsItems[categ][item]["buy"] * elementsScript.mult_factor["buy"], 0.01)
    parent.get_node(categ + "/" + item + "Buy").text = str(categsItems[categ][item]["buy"])
    parent.get_node(categ + "/" + item + "Qtt").text = str(categsItems[categ][item]["qtt"])
    parent.get_node("Coins").text = str(coins.show())
    parent.get_node("CoinsPerSec").text = coins.show_coins_per_sec()
    elementsScript.check_min_qtt(categ, item, container, self, categsItems)
    #print("btn signal")
    
