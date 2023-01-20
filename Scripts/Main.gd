extends Control

const coin = preload("res://Scripts/Coin.gd")
var coins = 0
var time = 0
var timeLimit = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	coins = coin.new()
	get_node("./Coins").text = str("%.2f" % coins.show()) + " C"
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Make things happen each SECOND
	time = time + delta
	if time > timeLimit:
		coins.add()
		get_node("./Coins").text = str("%.2f" % coins.show()) + " C"
		time = 0
	
