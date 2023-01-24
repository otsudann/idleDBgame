extends Control

const c = preload("res://Scripts/Coin.gd")
const svLd = preload("res://Scripts/SaveLoad.gd")
const elem = preload("res://Scripts/Elements.gd")

export var parent_path = NodePath(".")
var parent
var buyPriceLabel

var coins = c.new()
var saveLoad = svLd.new()
var elements = elem.new()
var time = 0
var timeLimit1 = 1
var timeLimit5 = 5
var timeSave = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  parent = get_node(parent_path).get_node("MainScrollContainer/MainVBoxContainer")
  buyPriceLabel = get_node(parent_path).get_node("MainScrollContainer/MainVBoxContainer/CoinUpgrade/BuyPrice")
  elements.fill_dicts(true)
  
  # Load data
  saveLoad.loadGame()
  coins.current_value = float(saveLoad.game_data.coins[0])
  coins.coin_add = float(saveLoad.game_data.coins[1])
  
  # show coins
  parent.get_node("Coins").text = coins.show()
  buyPriceLabel.text = "$" + str("%.2f" % coins.touch_coin_price)
  
  # build containers
  elements.build_container(elements.groups, parent, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    
  # Make things happen EACH SECOND
  time += delta
  if time >= timeLimit1:
    coins.add()
    # Show current coins
    parent.get_node("Coins").text = coins.show()
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
    parent.get_node("Coins").text = coins.show()

func _on_Btn_click(group_name, element_name):
  if coins.buy(elements.groups[group_name][1][element_name]["buy"]):
    elements.groups[group_name][1][element_name]["qtt"] += 1
    elements.groups[group_name][1][element_name]["buy"] = stepify(elements.groups[group_name][1][element_name]["buy"] * elements.multiplier_factor["sell"], 0.01)
    
    coins.coin_add += elements.groups[group_name][1][element_name]["sell"]
    
    parent.get_node(group_name+"/"+element_name+"Qtt").text = str(elements.groups[group_name][1][element_name]["qtt"])
    parent.get_node(group_name+"/"+element_name+"Buy").text = str(stepify(elements.groups[group_name][1][element_name]["buy"], 0.01))
    
    #if elements.groups[group_name][1][element_name]["qtt"] >= elements.groups[group_name][1][element_name]["min_qtt"]:
    if elements.groups[group_name][1][element_name]["qtt"] >= 3:
      elements.build_subcontainer(group_name, elements.groups[group_name][1], parent.get_node(group_name), self)
