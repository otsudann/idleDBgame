extends Control

const c = preload("res://Scripts/Coin.gd")
const svLd = preload("res://Scripts/SaveLoad.gd")
const elem = preload("res://Scripts/Elements.gd")

var parent
var buyPriceLabel
var touchQttLabel

var coins = c.new()
var saveLoad = svLd.new()
var categAndItems = elem.new()
var time = 0
var timeLimit1 = 1
var timeLimit5 = 5
var timeSave = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  parent = get_node("MainScrollContainer/MainVBoxContainer")
  buyPriceLabel = get_node("MainScrollContainer/MainVBoxContainer/CoinUpgrade/BuyPrice")
  touchQttLabel = get_node("MainScrollContainer/MainVBoxContainer/CoinUpgrade/CoinUpgQtt")
  categAndItems.fill_dicts(true)
  
  # Load data
  saveLoad.loadGame()
  coins.current_value = float(saveLoad.game_data.coins[0])
  coins.coin_add = float(saveLoad.game_data.coins[1])
  
  # show coins
  parent.get_node("Coins").text = coins.show()
  parent.get_node("CoinsSec").text = coins.show_current_per_sec()
  buyPriceLabel.text = "$" + str("%.2f" % coins.touch_coin_price)
  
  # build containers
  categAndItems.build_categ_container("fruit", "apple", parent, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    
  # Make things happen EACH SECOND
  time += delta
  if time >= timeLimit1:
    coins.add()
    # Show current coins
    parent.get_node("Coins").text = coins.show()
    parent.get_node("CoinsSec").text = coins.show_current_per_sec()
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
  if coins.buy(coins.touch_coin_price):
    coins.touch_upg()
    buyPriceLabel.text = "$" + str(stepify(coins.touch_coin_price, 0.01))
    touchQttLabel.text = str(coins.touch_coin_qtt)
    parent.get_node("Coins").text = coins.show()

func _on_Btn_click(categ, item, itemAttr, container):
  if coins.buy(itemAttr["buy"]):
    itemAttr["qtt"] += 1
    itemAttr["buy"] *= categAndItems.mult_factor["buy"]
    categAndItems.check_min_qtt(categ, item, container, self)
    
