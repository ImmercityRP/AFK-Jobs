RegisterServerEvent('afk_jobs:workStateSv')
AddEventHandler('afk_jobs:workStateSv', function(id, state)
	Config.AFK[id].active = state
    TriggerClientEvent('afk_jobs:workStateCl', -1, id, state)
end)

RegisterServerEvent('afk_jobs:raidStateSv')
AddEventHandler('afk_jobs:raidStateSv', function()
	Config.Raid.active = true
    TriggerClientEvent('afk_jobs:raidStateCl', -1, true)
	if Config.Raid.alert == true then
		local xPlayers = ESX.GetExtendedPlayers()
		for k,v in pairs(xPlayers) do
			for c,b in pairs(Config.PoliceJobs) do
				if v.job.name == b then
					serverNotify(xPlayer.source, Lang['cop_notify'])
				end
			end
		end
	end
	Wait(Config.Raid.timer)
	Config.Raid.active = false
    TriggerClientEvent('afk_jobs:raidStateCl', -1, false)
end)

RegisterServerEvent('afk_jobs:raidedSv')
AddEventHandler('afk_jobs:raidedSv', function()
	TriggerClientEvent('afk_jobs:raidedCl', -1)
end)

RegisterServerEvent('afk_jobs:reward')
AddEventHandler('afk_jobs:reward', function(type, id, partialPay)
	local xPlayer = ESX.GetPlayerFromId(source)
	local account, rewardLabel
	local amount = Config.Jobs[id].amount
	if partialPay then 
		amount = math.ceil((amount * partialPay) * Config.PartialPenalty)
	end
	for k,v in pairs(Config.JobTypes) do
		if v.type == type then
			account = v.reward
			rewardLabel = v.rewardLabel
		end
	end	
	if account == 'money' then
		xPlayer.addMoney(amount)
	else
		xPlayer.addAccountMoney(account, amount)
		serverNotify(source, Lang['money_reward']:format(amount, rewardLabel))
	end
end)

RegisterServerEvent('afk_jobs:rewardItem')
AddEventHandler('afk_jobs:rewardItem', function(type, id, partialPay)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item, rewardLabel
	local amount = Config.Jobs[id].amount
	if partialPay then 
		amount = math.ceil((amount * partialPay) * Config.PartialPenalty)
	end
	for k,v in pairs(Config.JobTypes) do
		if v.type == type then
			item = v.reward
			rewardLabel = v.rewardLabel
		end
	end
	xPlayer.addInventoryItem(item, amount)
	serverNotify(source, Lang['item_reward']:format(amount, rewardLabel))
end)

if Config.RestartCancel then
	AddEventHandler('txAdmin:events:scheduledRestart',function(eventData)
		if eventData.secondsRemaining == (Config.RestartMinute * 60) then
			TriggerClientEvent('afk_jobs:restartCancel', -1)
		end
	end)
end


-- Example Bundle Item - To use, uncomment the section by removing the --[[ above it and the ]] below it.
-- Make sure to check the [items] folder for the necessary SQL file for your database and item images for your inventory script.
-- You can adjust what items it gives and how much of each item - this is just an example for those new to ESX.

--[[
ESX.RegisterUsableItem('materialbundle', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getInventoryItem('materialbundle').count >= 1 then
		xPlayer.removeInventoryItem('materialbundle', 1)

		local metalAmount = math.random(2,3)
		local copperAmount = math.random(2,3)
		local ironAmount = math.random(2,3)
		local plasticAmount = math.random(4,5)
		local rubberAmount = math.random(4,5)

		xPlayer.giveInventoryItem('raw_metal', metalAmount)
		xPlayer.giveInventoryItem('copper', copperAmount)
		xPlayer.giveInventoryItem('iron', ironAmount)
		xPlayer.giveInventoryItem('plastic', plasticAmount)
		xPlayer.giveInventoryItem('rubber', rubberAmount)

		xPlayer.showNotification('You received a variety of materials!')
	end
end)
]]

