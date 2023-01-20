extends Control

const c = preload("res://Scripts/Coin.gd")
const svLd = preload("res://Scripts/SaveLoad.gd")
const cont = preload("res://Scripts/Container.gd")
const elem = preload("res://Scripts/Elements.gd")

export var parent_path = NodePath(".")
var parent

var coins = c.new()
var saveLoad = svLd.new()
var containers = cont.new()
var elements = elem.new()
var time = 0
var timeLimit1 = 1
var timeLimit5 = 5
var timeSave = 0

# Called when the node enters the scene tree for the first time.
func _ready():
  parent = get_node(parent_path).get_node("MainScrollContainer/MainVBoxContainer")
  
  # Load data
  saveLoad.loadGame()
  coins.current_value = float(saveLoad.game_data.coins[0])
  coins.coin_add = float(saveLoad.game_data.coins[1])
  
  # show coins
  parent.get_node("Coins").text = str("%.2f" % coins.show()) + " C"
  
  # build containers
  containers.build_container(elements.group, parent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
  # Make things happen EACH SECOND
  time += delta
  if time >= timeLimit1:
    coins.add()
    # Show current coins
    parent.get_node("Coins").text = str("%.2f" % coins.show()) + " C"
    time = 0
  
  # Make things happen EACH 5 SECONDS
  timeSave += delta
  if timeSave >= timeLimit5:
    saveLoad.saveGame(coins)
    timeSave = 0
