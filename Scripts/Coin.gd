extends Node

var current_value = 0
var coin_add = 0.01
var touch_coin_add = 0.01
var touch_coin_price = 0.01

func add():
  current_value += coin_add

func show():
  return current_value

func buy(value):
  if value > current_value:
    return false
  else:
    current_value -= value
    return true
    
func touch_add():
  current_value += touch_coin_add

func touch_upg():
  touch_coin_price *= 1.1
  coin_add += touch_coin_add
