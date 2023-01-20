var path="user://save_game.json";
var passFile="hdheinfhrjebfggu3lwqdww73iendymwhcgcfwksuidgb"


#Any number of variables of different types
var game_data = {}

func saveGame(coins):
	var file = File.new()

	game_data = {
		"coins": [coins.current_value, coins.coin_add],
		
	}

	file.open_encrypted_with_pass(path, File.WRITE, passFile)
	file.store_var(to_json(game_data), true)
	file.close()
	print("Saved")
	pass

func loadGame():
	var file = File.new()

	if file.file_exists(path):
		file.open_encrypted_with_pass(path, File.READ, passFile)
		var loadParam = parse_json(file.get_var(true));
		file.close()

		if loadParam!=null:
			game_data = loadParam;
			pass;
	pass;
