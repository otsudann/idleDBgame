var path="./save_game.json";
var passFile="hdheinfhrjebfggu3lwqdww73iendymwhcgcfwksuidgb"


#Any number of variables of different types
var game_data = {}

func saveGame(coins, categsItems, one_time_build=true):
  var file = File.new()

  game_data = {
    "coins": coins as Dictionary,
    "categsItems": categsItems as Dictionary,
    "one_time_build": one_time_build, 
  }

  file.open_encrypted_with_pass(path, File.WRITE, passFile)
  file.store_var(to_json(game_data), true)
  file.close()

  pass

func loadGame(coins, categsItems):
  var file = File.new()

  if file.file_exists(path):
    file.open_encrypted_with_pass(path, File.READ, passFile)
    var loadParam = parse_json(file.get_var(true));
    file.close()

    if loadParam != null:
      game_data = loadParam;
      pass
  else:
    saveGame(coins, categsItems)
    pass
  pass
