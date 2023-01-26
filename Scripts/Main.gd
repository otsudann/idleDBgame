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

# Called when the node enters the scene tree for the first time.
func _ready():
  parent = get_node("MainScrollContainer/MainVBoxContainer")
  elementsScript.fill_dicts(true)
  
  # Load data
  saveLoad.loadGame()
  coins.current_value = float(saveLoad.game_data.coins[0])
  coins.coin_add = float(saveLoad.game_data.coins[1])
  
  # show coins
  parent.get_node("Coins").text = coins.show()
  parent.get_node("CoinsPerSec").text = coins.show_current_per_sec()
  parent.get_node("CoinUpgrade/BuyPrice").text = "$" + str(stepify(coins.touch_coin_buy, 0.01))
  
  # build containers
  elementsScript.build_categ_container("fruit", "apple", parent, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    
  # Make things happen EACH SECOND
  time += delta
  if time >= timeLimit1:
    coins.add()
    # Show current coins
    parent.get_node("Coins").text = coins.show()
    parent.get_node("CoinsPerSec").text = coins.show_current_per_sec()
    time = 0
  
  # Make things happen EACH 5 SECONDS
  timeSave += delta
  if timeSave >= timeLimit5:
    saveLoad.saveGame(coins)
    timeSave = 0

func _on_AddCoin_pressed():
  coins.touch_add()
  parent.get_node("Coins").text = coins.show()

func _on_TouchUpgCoin_pressed():
  if coins.buy(coins.touch_coin_buy, coins.touch_coin_sell):
    coins.touch_upg()
    parent.get_node("CoinUpgrade/BuyPrice").text = "$" + str(stepify(coins.touch_coin_buy, 0.01))
    parent.get_node("CoinUpgrade/CoinUpgQtt").text = str(coins.touch_coin_qtt)
    parent.get_node("Coins").text = coins.show()
    parent.get_node("CoinsPerSec").text = coins.show_current_per_sec()

func _on_Btn_click(categ, item, itemAttr, container):
  if coins.buy(itemAttr["buy"], itemAttr["sell"]):
    categsItemsDict[categ][item]["qtt"] += 1
    categsItemsDict[categ][item]["buy"] = stepify(categsItemsDict[categ][item]["buy"] * elementsScript.mult_factor["buy"], 0.01)
    parent.get_node(categ + "/" + item + "Buy").text = str(categsItemsDict[categ][item]["buy"])
    parent.get_node(categ + "/" + item + "Qtt").text = str(categsItemsDict[categ][item]["qtt"])
    parent.get_node("Coins").text = str(coins.show())
    parent.get_node("CoinsPerSec").text = coins.show_current_per_sec()
    elementsScript.check_min_qtt(categ, item, container, self)
    
