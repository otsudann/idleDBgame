extends Node

var coin = {
  "currentValue": 0,
  "addSec": 0.01,
  "touchSellPrice": 0.01,
  "touchBuyPrice": 0.01,
  "touchCoinQtt": 0
}

func add():
  coin["currentValue"] += coin["addSec"]

func show():
  return str(stepify(coin["currentValue"], 0.01)) + " Coins"

func show_coins_per_sec():
  return str(stepify(coin["addSec"], 0.01)) + " C/s"

func buy(price, sell):
  if price > coin["currentValue"]:
    return false
  else:
    coin["currentValue"] -= price
    coin["addSec"] += sell
    return true
    
func touch_add():
  coin["currentValue"] += coin["touchSellPrice"]

func touch_upg():
  coin["touchBuyPrice"] = stepify(coin["touchBuyPrice"] * 1.1, 0.001)
  coin["touchSellPrice"] += 0.01
  coin["touchCoinQtt"] += 1
  
