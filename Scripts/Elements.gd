extends Node

var next_fctr = 1.15
var sell_fctr = 1.6
var buy_fctr = 1.8
var base_fixed_qtt = 15
var base_qtt = 15


## Individual Tables
# {<name>: [<enabled>, <quantity>, <sell_price>, <buy_price>]}
var fruits = {"apple": [true, 0, 0.03, 0.25],
              "apric": [false, 0, 0, 0],
              "avoca": [false, 0, 0, 0],
              "banan": [false, 0, 0, 0],
              "berry": [false, 0, 0, 0],
              
              }
var veggies = {"aspar": [false, 0, 0, 0],
              "bambo": [false, 0, 0, 0],
                
              }

## Group Tables
# <Name>: [<dict>, <enabled>]
var group = {"Fruit":[true, fruits],
            "Veggi":[false, veggies],
            
            }

# Ex: upd_val(group['Market'])
func buy(element, coins, container):
  # Test if can buy
  if coins.buy(element[3]):
    # Increase Quantity
    element[1] += 1
    # Increase Buy Price
    element[3] *= 0.1
    # Update coin per second value
    coins.coin_add += element[2]
    
    # If reach min buy, enable the next
    if element[1] >= base_qtt:
      base_qtt *= next_fctr
      container.queue_free()
      container.build_container()
  
func calc_values(element, checked):
  #this is a one time function to setup base sell/buy values
  for el in element:
    var subelements = element[el][1]
    for sub in subelements:
      print(sub)
    
