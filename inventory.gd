extends Node

#Variables and Constants


#holds every item
const ITEMS : Dictionary = {
	"heavy_thing":  {
		"name":"Heavy Thing",
		"type":"Junk",
		"weight":32,
		"value":9,
		"desc":"this shit is heavy",
		"quantity":1
	},
	"value_thing":  {
		"name":"Value Thing",
		"type":"Junk",
		"weight":1,
		"value":99999, 
		"desc":"Oh my oh my i have found you nigga",
		"quantity":1
	},
	"test_item": {
		"name":"Test Item",
		"type":"Junk",
		"weight":1,
		"value":1,
		"desc":"testing item",
		"quantity":1
	}
}

#the player's inventory
var inventory = {
	"money":0
}

#the shop inventory
var shop = {
	"money":1000,
	"heavy_thing": ITEMS["heavy_thing"]
}

#Functions

#func money(way: String, amt: int):
#	match way:
#		"add":
#			inventory["money"] += amt
#		"remove":
#			inventory["money"] -= amt
#		"set":
#			inventory["money"] = amt
#		"show":
#			return inventory["money"]

#global
func item_value_get(item_key):
	return ITEMS[item_key]["value"]
	
func item_weight_get(item_key):
	return ITEMS[item_key]["weight"]


#Shop inv

func shop_money_add(amt: int):
	shop["money"] += amt

func shop_money_remove(amt: int):
	shop["money"] -= amt

func shop_money_set(amt: int):
	shop["money"] = amt

func shop_money_get():
	return shop["money"] 

func shop_item_add(item_key):
	if item_key in ITEMS:
		#if item already exists add 1 to quantity value
		if item_key in shop:
			shop[item_key]["quantity"] +=1
		#else add the item
		else:
			shop[item_key] = ITEMS[item_key]
	#if trying to add item that does not exist in the dictionary
	else:
		print("cannot add item to shop \"" + str(item_key) + "\": does not even exist")

func shop_item_remove(item_key):
	#if the item exists
	if item_key in shop:
		#if there's only one, remove it
		if shop[item_key]["quantity"] == 1:
			shop.erase(item_key)
		#if there's more than one, decrement quantity
		else:
			shop[item_key]["quantity"] -= 1
	#if item doesn't exist
	else:
		print("cannot remove item from shop \"" + str(item_key) + "\": not in shop")


#Player inv

func money_add(amt: int):
	inventory["money"] += amt

func money_remove(amt: int):
	inventory["money"] -= amt

func money_set(amt: int):
	inventory["money"] = amt

func money_get():
	return inventory["money"] 

func item_add(item_key):
	if item_key in ITEMS:
		#if item already exists add 1 to quantity value
		if item_key in inventory:
			inventory[item_key]["quantity"] +=1
		#else add the item
		else:
			inventory[item_key] = ITEMS[item_key]
	#if trying to add item that does not exist in the dictionary
	else:
		print("cannot add item \"" + str(item_key) + "\": does not even exist")

func item_remove(item_key):
	#if the item exists
	if item_key in inventory:
		#if there's only one, remove it
		if inventory[item_key]["quantity"] == 1:
			inventory.erase(item_key)
		#if there's more than one, decrement quantity
		else:
			inventory[item_key]["quantity"] -= 1
	#if item doesn't exist
	else:
		print("cannot remove item \"" + str(item_key) + "\": not in inventory")

func item_buy(item_key):
	if item_key in ITEMS:
		if item_key in shop:
			#find item price
			var item_price = item_value_get(item_key)
			#if shop can afford
			if money_get() >= item_price:
				#rem money
				money_remove(item_price)
				#add money to shop
				shop_money_add(item_price)
				#rem from shop
				shop_item_remove(item_key)
				#add item
				item_add(item_key)
			#if not affordable
			else:
				print(str(money_get()) + " is not enough money to buy " + str(ITEMS[item_key]))
		else:
			print("cannot buy item " + str(item_key) + ": not in shop")
	else:
		print("cannot buy item \"" + str(item_key) + "\": does not even exist")

func item_sell(item_key):
	if item_key in ITEMS:
		#if p has item
		if item_key in inventory:
			var item_price = item_value_get(item_key)
			#if the shop can afford it
			if shop_money_get() >= item_price:
				#remove inv item
				item_remove(item_key)
				#add item to shop
				shop_item_add(item_key)
				#rem shop money
				shop_money_remove(item_price)
				#add money
				money_add(item_price)
			#if shop cant afford
			else:
				print("shop cannot afford " + str(item_key) + ", value:" + str(item_price) + ", shop money: " + str(shop_money_get()))
		else:
			print("cannot sell item "+ str(item_key) +": not in inventory")
	else:
		print("cannot sell item \"" + str(item_key) + "\": does not even exist")

#Save inventory to file
func inv_save():
	#Create new file
	var save_inv = File.new()
	#Open the file
	save_inv.open("user://inv.save", File.WRITE)
	#Store the "inventory" Dictionary in JSON format
	save_inv.store_line(to_json(inventory))
	#Close
	save_inv.close()

#Load inventory from file
func inv_load():
	#new file
	var loaded_inv = File.new()
	#load inv in read mode
	loaded_inv.open("user://inv.save", File.READ)
	#turn the string into a dictionary
	inventory = parse_json(loaded_inv.get_line())
	#close the file
	loaded_inv.close()

#Wipe and save the inventory
func inv_clear():
	inventory = {}
	inv_save()

func _ready():
	inv_load()
	print(inventory)
	inv_save()
	print(str(OS.get_user_data_dir()))
