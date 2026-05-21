local Devs = table.freeze({
	["Noob Dev"] = {
		Odd = 2,
		Category = "COMMON",
		MoneyPerSecond = 1,
		SellPrice = 10,
		IsExclusive = false,
		Order = 1,
		GUI = {
			Label = "Noob Dev",
		},
	},

	["Pro Dev"] = {
		Odd = 3,
		Category = "COMMON",
		MoneyPerSecond = 3,
		SellPrice = 30,
		IsExclusive = false,
		Order = 2,
		GUI = {
			Label = "Pro Dev",
		},
	},

	["Marketing Operator"] = {
		Odd = 5,
		Category = "COMMON",
		MoneyPerSecond = 5,
		SellPrice = 50,
		IsExclusive = false,
		Order = 3,
		GUI = {
			Label = "Marketing Operator",
		},
	},

	["LUA Nerd"] = {
		Odd = 10,
		Category = "INCOMMON",
		MoneyPerSecond = 10,
		SellPrice = 100,
		IsExclusive = false,
		Order = 4,
		GUI = {
			Label = "LUA Nerd",
		},
	},

	["Artist"] = {
		Odd = 18,
		Category = "INCOMMON",
		MoneyPerSecond = 18,
		SellPrice = 180,
		IsExclusive = false,
		Order = 5,
		GUI = {
			Label = "Artist",
		},
	},

	["Angry Dev"] = {
		Odd = 25,
		Category = "RARE",
		MoneyPerSecond = 25,
		SellPrice = 250,
		IsExclusive = false,
		Order = 6,
		GUI = {
			Label = "Angry Dev",
		},
	},

	["Management"] = {
		Odd = 55,
		Category = "RARE",
		MoneyPerSecond = 55,
		SellPrice = 550,
		IsExclusive = false,
		Order = 7,
		GUI = {
			Label = "Management",
		},
	},

	["CEO"] = {
		Odd = 70,
		Category = "EPIC",
		MoneyPerSecond = 70,
		SellPrice = 700,
		Order = 8,
		GUI = {
			Label = "CEO",
		},
	},

	["Investor"] = {
		Odd = 110,
		Category = "EPIC",
		MoneyPerSecond = 110,
		SellPrice = 1100,
		Order = 9,
		GUI = {
			Label = "Investor",
		},
	},

	["Debugger"] = {
		Odd = 150,
		Category = "LEGENDARY",
		MoneyPerSecond = 150,
		SellPrice = 1500,
		Order = 10,
		GUI = {
			Label = "Debugger",
		},
	},

	["Greedy Dev"] = {
		Odd = 200,
		Category = "LEGENDARY",
		MoneyPerSecond = 200,
		SellPrice = 2000,
		Order = 11,
		GUI = {
			Label = "Greedy Dev",
		},
	},

	["Red Dev"] = {
		Odd = 350,
		Category = "MYTHICAL",
		MoneyPerSecond = 350,
		SellPrice = 3500,
		Order = 12,
		GUI = {
			Label = "Red Dev",
		},
	},

	["Data Boss"] = {
		Odd = 550,
		Category = "MYTHICAL",
		MoneyPerSecond = 550,
		SellPrice = 5500,
		Order = 13,
		GUI = {
			Label = "Data Boss",
		},
	},

	["Homeoffice Dev"] = {
		Odd = 800,
		Category = "DIVINE",
		MoneyPerSecond = 800,
		SellPrice = 8000,
		Order = 14,
		GUI = {
			Label = "Homeoffice Dev",
		},
	},

	["Data Scientist"] = {
		Odd = 1200,
		Category = "DIVINE",
		MoneyPerSecond = 1200,
		SellPrice = 12000,
		Order = 15,
		GUI = {
			Label = "Data Scientist",
		},
	},

	["Flexing Dev"] = {
		Odd = 2400,
		Category = "DIVINE",
		MoneyPerSecond = 2400,
		SellPrice = 24000,
		Order = 16,
		GUI = {
			Label = "Flexing Dev",
		},
	},

	["Crazy Dev"] = {
		Odd = 4000,
		Category = "DIVINE",
		MoneyPerSecond = 4000,
		SellPrice = 40000,
		Order = 17,
		GUI = {
			Label = "Crazy Dev",
		},
	},

	["Brainrot Dev"] = {
		Odd = 500,
		Category = "DIVINE",
		MoneyPerSecond = 100,
		SellPrice = 100 * 10,
		Order = 18,
		IsExclusive = true,
		GUI = {
			Label = "Brainrot Dev",
		},
	},

	["Hacker Dev"] = {
		Odd = 500,
		Category = "DIVINE",
		MoneyPerSecond = 1000 * 10,
		SellPrice = 1000 * 100,
		Order = 19,
		IsExclusive = true,
		GUI = {
			Label = "Hacker Dev",
		},
	},

	["Ninja Dev"] = {
		Odd = 500,
		Category = "DIVINE",
		MoneyPerSecond = 110,
		SellPrice = 110 * 10,
		Order = 20,
		IsExclusive = true,
		GUI = {
			Label = "Ninja Dev",
		},
	},

	["Tourist Dev"] = {
		Odd = 500,
		Category = "DIVINE",
		MoneyPerSecond = 120,
		SellPrice = 120 * 10,
		Order = 21,
		IsExclusive = true,
		GUI = {
			Label = "Tourist Dev",
		},
	},
})
return Devs
