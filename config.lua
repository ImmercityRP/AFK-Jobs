Config = {}
-- Police Raid Settings
Config.Raid = { 									-- Police Raid Option to shut down all raidable jobs
	enable = true, 									-- true enables the police raid option
	cancel = true, 									-- true means a raid will cancel all active AFK workers at all raidable locations
	timer = 60 * 60 * 1000, 						-- Raid Shutdown Timer - 1 Hour Default
	alert = true, 									-- true enables raid alert, which is sent to all active police
	pos = vector3(745.4022, -1909.716, 29.46199), 	-- Raid Marker Location
	marker = {enable=true, drawDist=5.0, type=0, color={r=40,g=40,b=200,a=200}, scale={x=1.0,y=1.0,z=1.0}}, -- Marker settings: https://docs.fivem.net/docs/game-references/markers/
	drawText = '~r~[E]~s~ ~b~Police ~r~Raid~s~', 	-- DrawText Label
	keybind = 38, 									-- Keybind for Raid
	active = false, 								-- Don't Touch - Leave false
}

Config.PoliceJobs = {'police'} 						-- List of police jobs to use for above Raid, if enabled. Can be a table of multiple: {'police','sheriff','sast'}

Config.AutoHeal = true 								-- Sets esx_status hunger + thirst back to max value (10000000)
Config.HealStress = true 							-- Sets esx_status stress back to bottom value (10). Only works if Config.AutoHeal = true
Config.HealFrequency = 15 * 60 * 1000 				-- Heal AFK workers every X minutes. Default = 15.

Config.MenuPos = 'top-left'							-- ESX Menu Position
Config.ShowRewardAmount = true 						-- Display the reward label + amount in the Job Menu

Config.PosLoop = 500 								-- How often the script checks for players position. Default is 500. Lower = checks quicker but more resources. Too high and players won't see the markers until standing at the spot for a bit.
Config.SleepLoop = 1000								-- How often the marker/text distance loop runs. Default is 1000. Lower = checks quicker but more resources. Too high and players won't see the markers until standing at the spot for a bit.
Config.TimerCheck = 1000							-- How often the Timer that tracks time for partial payments updates. Default is 1000. Warning - this timer needs to finish before it unfreezes a player after they cancel a job.

Config.PartialPenalty = 1.0							-- Penalty applied to partial payments. 1.0 = no penalty. 0.85 = 15% penalty. 0.0 = 100% penalty/no pay. Basically a pay multiplier when someone cancels/gets raided - not advised to go above 1.0.


Config.JobTypes = {
	[1] = {
		type = 'crim', 								-- Unique Type name - type must match for Config.JobTypes, Config.AFK, and Config.Jobs. Can be set to anything, but must be unique for each different reward type
		label = 'Anonymous Hacking', 				-- ESX Menu Title Label
		pay = 'money', 								-- 'money' or 'item' - you decide which money account or item in below line
		reward = 'black_money', 					-- if pay = 'money' then reward = 'money', 'bank', or 'black_money' (ESX accounts). If pay = 'item' then reward = 'itemName'. Example: reward = 'lootbundle',
		rewardLabel = 'Dirty Money', 				-- Used in notifications to display the proper name of the reward, and in menus if Config.ShowRewardAmount = true,
		raidable = true, 							-- Whether to disable all jobs of this type after a Police Raid, if Config.Raid.enable = true,
	},
	[2] = {
		type = 'legal',
		label = 'Life Invader Support',
		pay = 'money',
		reward = 'bank',
		rewardLabel = 'Bank Deposit',
		raidable = false,
	},
	[3] = {
		type = 'material',
		label = 'Material Gathering',
		pay = 'item', 								-- Only 1 type of item can be given. If you'd to do more, I'd recommend creating a 'bundle' item - example given at bottom of server.lua
		reward = 'materialbundle', 					-- To use this item, you must uncomment the code at the bottom of server.lua, add the items to your database via the items.sql, and copy the images to your inventory script
		rewardLabel = 'Material Bundles',
		raidable = false,
	}
}



Config.AFK = {	
			-- Crim Type: Patoche's Free Anonymous MLO - https://www.gta5-mods.com/maps/mlo-anonymous-fivem-sp-ready
	[1] = { 										-- ID - Start at 1 and don't skip any numbers
		type = 'crim', 								-- Unique Type name - type must match for Config.JobTypes, Config.AFK, and Config.Jobs. Can be set to anything, but be unique for each different job type
		pos = vector3(750.7491, -1907.543, 29.46198), -- Coords of marker/animation
		heading = 176.5019, 						-- Heading of marker/animation
		dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus', -- false if no animation OR set to an animation dictionary - https://alexguirre.github.io/animations-list/
		lib = 'loop', 								-- false if no animation OR set to an animation clip - https://alexguirre.github.io/animations-list/
		prop = false, 								-- false OR set a prop to attach to hands during animation. Example: prop = 'prop_w_me_hatchet',
		blip = {enable=false, str='AFK Hacking', sprite=464, display=2, color=0, scale=1.0}, 	-- Blip settings - https://docs.fivem.net/docs/game-references/blips/
		marker = {enable=true, drawDist=5.0, type=0, color={r=200,g=40,b=40,a=200}, scale={x=1.0,y=1.0,z=1.0}}, 	-- Marker settings - https://docs.fivem.net/docs/game-references/markers/
		drawText = '~r~[E]~s~ AFK Hacking',			-- 3D Draw Text label
		progLabel = 'AFK Anonymous Hacking', 		-- Progress Bar text/label
		keybind = 38, 								-- Open Job Menu Keybind - https://docs.fivem.net/docs/game-references/controls/
		active = false, 							-- Don't Touch - Leave false
	},
	[2] = {
		type = 'crim',
		pos = vector3(752.8446, -1909.924, 29.45423),
		heading = 314.4059,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},
	[3] = {
		type = 'crim',
		pos = vector3(757.3929, -1912.025, 29.46198),
		heading = 263.0594,
		dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus',
		lib = 'loop',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},
	[4] = {
		type = 'crim',
		pos = vector3(753.9171, -1904.17, 29.46201),
		heading = 348.8148,
		dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus',
		lib = 'loop',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},
	[5] = {
		type = 'crim',
		pos = vector3(764.3701, -1905.138, 29.45822),
		heading = 187.7039,
		dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus',
		lib = 'loop',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},
	[6] = {
		type = 'crim',
		pos = vector3(759.9649, -1911.976, 29.45822),
		heading = 74.71516,
		dict = 'mp_prison_break',
		lib = 'hack_loop',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},
	[7] = {
		type = 'crim',
		pos = vector3(759.9385, -1914.224, 29.45822),
		heading = 103.3424,
		dict = 'mp_prison_break',
		lib = 'hack_loop',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},
	[8] = {
		type = 'crim',
		pos = vector3(766.2639, -1914.86, 29.45822),
		heading = 260.5952,
		dict = 'mp_prison_break',
		lib = 'hack_loop',
		prop = false,
		blip = {enable = false, str = 'AFK Hacking', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Hacking',
		progLabel = 'AFK Anonymous Hacking',
		keybind = 38,
		active = false,
	},

			-- Legal Type: Life Invader default IPL
	[9] = {
		type = 'legal',
		pos = vector3(-1062.44, -248.8868, 43.52528),
		heading = 297.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = true, str = 'AFK Work', sprite = 464, display = 2, color = 1, scale = 1.25},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[10] = {
		type = 'legal',
		pos = vector3(-1063.605, -246.6482, 43.52525),
		heading = 297.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[11] = {
		type = 'legal',
		pos = vector3(-1060.928, -246.0718, 43.52525),
		heading = 117.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[12] = {
		type = 'legal',
		pos = vector3(-1060.256, -247.6749, 43.52525),
		heading = 92.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[13] = {
		type = 'legal',
		pos = vector3(-1060.357, -244.9725, 43.52524),
		heading = 297.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[14] = {
		type = 'legal',
		pos = vector3(-1057.864, -243.5093, 43.52525),
		heading = 72.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[15] = {
		type = 'legal',
		pos = vector3(-1055.773, -246.0213, 43.52528),
		heading = 322.4999,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[16] = {
		type = 'legal',
		pos = vector3(-1056.141, -243.3247, 43.52525),
		heading = 262.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[17] = {
		type = 'legal',
		pos = vector3(-1053.212, -245.1427, 43.52525),
		heading = 117.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[18] = {
		type = 'legal',
		pos = vector3(-1052.671, -244.077, 43.52516),
		heading = 312.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[19] = {
		type = 'legal',
		pos = vector3(-1053.965, -241.7114, 43.52525),
		heading = 297.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[20] = {
		type = 'legal',
		pos = vector3(-1050.776, -240.8017, 43.52528),
		heading = 52.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[21] = {
		type = 'legal',
		pos = vector3(-1050.037, -243.4104, 43.52525),
		heading = 52.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[22] = {
		type = 'legal',
		pos = vector3(-1057.119, -232.5291, 43.52533),
		heading = 252.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},
	[23] = {
		type = 'legal',
		pos = vector3(-1053.044, -230.3057, 43.52514),
		heading = 162.5,
		dict = 'mp_safehouselost@boss',
		lib = 'lost_boss_keyboard_talk',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Work',
		progLabel = 'AFK Life Invader Work',
		keybind = 38,
		active = false,
	},

			-- Material Type: Roger's Salvage & Scrap default IPL
	[24] = {
		type = 'material',
		pos = vector3(-617.9619, -1628.444, 33.02738),
		heading = 287.9215,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = true, str = 'AFK Gathering', sprite = 464, display = 2, color = 1, scale = 1.25},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[25] = {
		type = 'material',
		pos = vector3(-620.4111, -1631.582, 33.01058),
		heading = 177.0476,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[26] = {
		type = 'material',
		pos = vector3(-609.3627, -1631.986, 33.02524),
		heading = 135.4761,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[27] = {
		type = 'material',
		pos = vector3(-582.886, -1625.09, 33.07048),
		heading = 163.9709,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[28] = {
		type = 'material',
		pos = vector3(-577.3206, -1626.524, 33.02081),
		heading = 215.5206,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[29] = {
		type = 'material',
		pos = vector3(-567.2581, -1627.525, 33.04188),
		heading = 350.1397,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[30] = {
		type = 'material',
		pos = vector3(-569.6914, -1604.957, 27.0108),
		heading = 238.3622,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[31] = {
		type = 'material',
		pos = vector3(-575.1212, -1610.728, 27.03493),
		heading = 148.4983,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[32] = {
		type = 'material',
		pos = vector3(-580.4703, -1601.128, 27.01081),
		heading = 26.22721,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[33] = {
		type = 'material',
		pos = vector3(-585.0466, -1609.583, 27.01082),
		heading = 196.6526,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[34] = {
		type = 'material',
		pos = vector3(-590.4719, -1602.551, 27.01082),
		heading = 8.50996,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
	[35] = {
		type = 'material',
		pos = vector3(-595.0851, -1610.85, 27.01081),
		heading = 174.778,
		dict = 'creatures@rottweiler@tricks@',
		lib = 'petting_franklin',
		prop = false,
		blip = {enable = false, str = 'AFK Work', sprite = 464, display = 2, color = 0, scale = 1.0},
		marker = {enable = true, drawDist = 5.0, type = 0, color = {r = 200, g = 40, b = 40, a = 200}, scale = {x = 1.0, y = 1.0, z = 1.0}},
		drawText = '~r~[E]~s~ AFK Gathering',
		progLabel = 'AFK Material Gathering',
		keybind = 38,
		active = false,
	},
}

Config.Jobs = {

	-- Crim Type
	[1] = {											-- ID - Start at 1 and don't skip any numbers. Can make as many jobs per type as you desire.
		time = 5 * 60 * 1000, 						-- Job/ProgressBar/Animation Timer
		text = '5 Mins', 							-- Job Label for Menu - Menu is sorted automatically from shortest time to longest. Will also display Reward + Amount if Config.ShowRewardAmount = true,
		type = 'crim', 								-- Unique Type name - type must match for Config.JobTypes, Config.AFK, and Config.Jobs. Can be set to anything, but be unique for each different job type
		amount = 1975,  							-- Amount of Rewards given upon successful job completion -- either Money or Items
	},
	[2] = {
		time = 15 * 60 * 1000,
		text = '15 Mins',
		type = 'crim',
		amount = 5775, 
	},
	[3] = {
		time = 30 * 60 * 1000,
		text = '30 Mins',
		type = 'crim',
		amount = 11050, 
	},
	[4] = {
		time = 60 * 60 * 1000,
		text = '1 Hour',
		type = 'crim',
		amount = 21050, 
	},
	[5] = {
		time = 2 * 60 * 60 * 1000,
		text = '2 Hours',
		type = 'crim',
		amount = 40000, 
	},
	[6] = {
		time = 3 * 60 * 60 * 1000,
		text = '3 Hours',
		type = 'crim',
		amount = 57000, 
	},
	[7] = {
		time = 4 * 60 * 60 * 1000,
		text = '4 Hours',
		type = 'crim',
		amount = 71500, 
	},
	[8] = {
		time = 5 * 60 * 60 * 1000,
		text = '5 Hours',
		type = 'crim',
		amount = 84500, 
	},
	-- Legal Type
	[1] = {
		time = 5 * 60 * 1000,
		text = '5 Mins',
		type = 'legal',
		amount = 1666,
	},
	[2] = {
		time = 15 * 60 * 1000,
		text = '15 Mins',
		type = 'legal',
		amount = 4750, 
	},
	[3] = {
		time = 30 * 60 * 1000,
		text = '30 Mins',
		type = 'legal',
		amount = 9000, 
	},
	[4] = {
		time = 60 * 60 * 1000,
		text = '1 Hour',
		type = 'legal',
		amount = 17000, 
	},
	[5] = {
		time = 2 * 60 * 60 * 1000,
		text = '2 Hours',
		type = 'legal',
		amount = 33000, 
	},
	[6] = {
		time = 3 * 60 * 60 * 1000,
		text = '3 Hours',
		type = 'legal',
		amount = 48000, 
	},
	[7] = {
		time = 4 * 60 * 60 * 1000,
		text = '4 Hours',
		type = 'legal',
		amount = 62000, 
	},
	[8] = {
		time = 5 * 60 * 60 * 1000,
		text = '5 Hours',
		type = 'legal',
		amount = 75000, 
	},

	--Material Type
	[17] = {
		time = 5 * 60 * 1000,
		text = '5 Mins',
		type = 'material',
		amount = 5,
	},
	[18] = {
		time = 15 * 60 * 1000,
		text = '15 Mins',
		type = 'material',
		amount = 14, 
	},
	[19] = {
		time = 30 * 60 * 1000,
		text = '30 Mins',
		type = 'material',
		amount = 27, 
	},
	[20] = {
		time = 60 * 60 * 1000,
		text = '1 Hour',
		type = 'material',
		amount = 52, 
	},
	[21] = {
		time = 2 * 60 * 60 * 1000,
		text = '2 Hours',
		type = 'material',
		amount = 100,
	},
	[22] = {
		time = 3 * 60 * 60 * 1000,
		text = '3 Hours',
		type = 'material',
		amount = 144, 
	},
	[23] = {
		time = 4 * 60 * 60 * 1000,
		text = '4 Hours',
		type = 'material',
		amount = 184, 
	},
	[24] = {
		time = 5 * 60 * 60 * 1000,
		text = '5 Hours',
		type = 'material',
		amount = 220, 
	},
}

-- Client Notifications
function clientNotify(msg)
	ESX.ShowNotification(msg, duration)
	-- Add Your Own:
end

-- Server Notifications
function serverNotify(source, msg)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.showNotification(msg)
	-- Add Your Own:
end

Lang = {
	['raid_active'] = '~b~Police~s~ recently ~r~Raided~s~ and shut down the network, come back later!',
	['cop_notify'] = '~b~LSPD~s~ has ~r~Raided~s~ the ~p~AFK Hacker\'s Den~s~!',
	['raided'] = '~b~LSPD~s~ has ~r~Raided~s~ the ~p~AFK Hacker\'s Den~s~ and cut your work short!',
	['money_reward'] = 'You received ~g~$%s~s~ ~r~%s~s~ for your work!',
	['item_reward'] = 'You received ~g~%sx~s~ ~r~%s~s~ for your work!',
}