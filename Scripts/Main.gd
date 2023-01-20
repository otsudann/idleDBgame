extends Control

const coin = preload("res://Scripts/Coin.gd")
const saveLoadGame = preload("res://Scripts/SaveLoad.gd")

var coins = coin.new()
var saveLoad = saveLoadGame.new()
var time = 0
var timeLimit = 1
var timeSave = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	saveLoad.loadGame()
	print(saveLoad.game_data.coins[0])
	coins.current_value = float(saveLoad.game_data.coins[0])
	get_node("MainScrollContainer/MainVBoxContainer/Coins").text = str("%.2f" % coins.show()) + " C"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make things happen EACH SECOND
	time += delta
	if time > timeLimit:
		coins.add()
		get_node("MainScrollContainer/MainVBoxContainer/Coins").text = str("%.2f" % coins.show()) + " C"
		time = 0
	
	# Make things happen EACH 5 SECONDS
	timeSave += delta
	if timeSave >= 5:
		saveLoad.saveGame(coins)
		timeSave = 0
