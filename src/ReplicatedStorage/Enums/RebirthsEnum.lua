local Rebirths = table.freeze({
	[1] = {
		Requirements = {
			{
				Type = "CASH",
				Amount = 1000000, -- 1M,
			},
		},
		Awards = {
			{
				Type = "FLOOR",
			},

			{
				Type = "CASH",
				Amount = 1000,
			},

			{
				Type = "CASH_MULTIPLIER",
				Amount = 0.5,
			},
		},
	},

	-----------------------------------------------
	---------------- 2° Rebirth -------------------
	-----------------------------------------------

	[2] = {
		Requirements = {
			{
				Type = "CASH",
				Amount = 1000000 * 250, -- 250M,
			},
		},
		Awards = {
			{
				Type = "FLOOR",
			},

			{
				Type = "CASH",
				Amount = 1000,
			},

			{
				Type = "CASH_MULTIPLIER",
				Amount = 0.5,
			},
		},
	},

	-----------------------------------------------
	---------------- 3° Rebirth -------------------
	-----------------------------------------------

	[3] = {
		Requirements = {
			{
				Type = "CASH",
				Amount = (1000000 * 250) * 5, -- 1.5B,
			},
		},
		Awards = {
			{
				Type = "FLOOR",
			},

			{
				Type = "CASH",
				Amount = 1000,
			},

			{
				Type = "CASH_MULTIPLIER",
				Amount = 0.5,
			},
		},
	},

	-----------------------------------------------
	---------------- 4° Rebirth -------------------
	-----------------------------------------------

	[4] = {
		Requirements = {
			{
				Type = "CASH",
				Amount = 1000000000 * 200, -- 200B
			},
		},
		Awards = {
			{
				Type = "FLOOR",
			},

			{
				Type = "CASH",
				Amount = 1000,
			},

			{
				Type = "CASH_MULTIPLIER",
				Amount = 0.5,
			},
		},
	},

	-----------------------------------------------
	---------------- 5° Rebirth -------------------
	-----------------------------------------------

	[5] = {
		Requirements = {
			{
				Type = "CASH",
				Amount = 1000000000000 * 10,
			},
		},
		Awards = {
			{
				Type = "FLOOR",
			},

			{
				Type = "CASH",
				Amount = 1000,
			},

			{
				Type = "CASH_MULTIPLIER",
				Amount = 0.5,
			},
		},
	},
})

return Rebirths
