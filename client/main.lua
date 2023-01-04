local isCop, afkActive, canRaid, timerActive = false, false, false, false
local partialPay, timer = 0, 0
player = nil
coords = {}

CreateThread(function()
    while true do
		player = PlayerPedId()
		coords = GetEntityCoords(player)
        Wait(Config.PosLoop)
    end
end)

CreateThread(function()
	for k,v in pairs(Config.AFK) do
		local b = v.blip
		if b.enable then
			local blip = AddBlipForCoord(v.pos)
			SetBlipSprite(blip, b.sprite)
			SetBlipDisplay(blip, b.display)
			SetBlipScale  (blip, b.scale)
			SetBlipColour (blip, b.color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(b.str)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

if Config.Raid.enable then
	CreateThread(function()		
		while not ESX.IsPlayerLoaded() do
			Wait(500)
		end
		PlayerData = ESX.GetPlayerData()
		job = PlayerData.job.name
		isCop = copCheck()
	end)

	RegisterNetEvent('esx:setJob')
	AddEventHandler('esx:setJob', function(newJob)
		job = newJob.name
		isCop = copCheck()
	end)

	function copCheck()
		for k,v in pairs(Config.PoliceJobs) do
			if job == v then
				isCop = true
				return true
			end
		end
		isCop = false
		return false
	end	
end

function Text3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

CreateThread(function()
    while true do
		Wait(1)
		local sleep = true
		if Config.Raid.enable then
			if isCop then
				local raid = Config.Raid
				local distance = #(vector3(coords.x, coords.y, coords.z) - raid.pos)
				local mk = raid.marker
				if distance <= mk.drawDist and not raid.active then
					sleep = false 
					if distance >= 1.25 and mk.enable then 
						DrawMarker(mk.type, raid.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 1.25 then
						Text3D(raid.pos.x, raid.pos.y, raid.pos.z, raid.drawText)
						if IsControlJustPressed(0, raid.keybind) then
							TriggerServerEvent('afk_jobs:raidStateSv')
							if Config.Raid.cancel then
								TriggerServerEvent('afk_jobs:raidedSv')
							end
						end
					end
				end
			else
				for k,v in pairs(Config.AFK) do
					local distance = #(vector3(coords.x, coords.y, coords.z) - v.pos)
					local mk = v.marker
					if distance <= mk.drawDist and not afkActive and not v.active then
						sleep = false 
						if distance >= 1.25 and mk.enable then 
							DrawMarker(mk.type, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
						elseif distance < 1.25 then
							Text3D(v.pos.x, v.pos.y, v.pos.z, v.drawText)
							if IsControlJustPressed(0, v.keybind) then
								if raidCheck(v.type) then
									clientNotify(Lang['raid_active'])
								else
									afkActive = true
									afkWork(k, v.type)
								end
							end
						end
					end
				end
			end
		else
			for k,v in pairs(Config.AFK) do
				local distance = #(vector3(coords.x, coords.y, coords.z) - v.pos)
				local mk = v.marker
				if distance <= mk.drawDist and not afkActive and not v.active then
					sleep = false 
					if distance >= 1.25 and mk.enable then 
						DrawMarker(mk.type, v.pos, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, mk.scale.x, mk.scale.y, mk.scale.z, mk.color.r, mk.color.g, mk.color.b, mk.color.a, false, true, 2, false, false, false, false)
					elseif distance < 1.25 then
						Text3D(v.pos.x, v.pos.y, v.pos.z, v.drawText)
						if IsControlJustPressed(0, v.keybind) then
							afkActive = true
							afkWork(k, v.type)
						end
					end
				end
			end
		end
		if sleep then Wait(Config.SleepLoop) end
    end
end)

function raidCheck(type)
	for k,v in pairs(Config.JobTypes) do
		if v.type == type and v.raidable == true then
			canRaid = true
			if Config.Raid.active then
				return true
			end
		end
	end
	return false
end

function afkWork(id, type)
	local elements = {}
	local rewardText, titleLabel, pay, text
	for k,v in pairs(Config.JobTypes) do
		if v.type == type then
			rewardText = v.rewardLabel
			titleLabel = v.label
			pay = v.pay
		end
	end
    for k,v in pairs(Config.Jobs) do
		if type == v.type then
			if Config.ShowRewardAmount then
				if pay == 'item' then
					text = v.text..' - '..rewardText..' x'..v.amount
				else
					text = v.text..' - $'..v.amount..' '..rewardText
				end
			else
				text = v.text
			end
			table.insert(elements, {
				label = text,
				time = v.time,
				type = v.type,
				value = k
			})
		end
    end
    table.sort(elements, function(a, b)
        return a.time < b.time
    end)	
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'job_list',
        {
            title = titleLabel,
            align = Config.MenuPos or 'top-left',
            elements = elements
        },
    function(data, menu)
        local option = data.current
		local spot = Config.AFK[id]
        if option then
            menu.close()
			TriggerServerEvent('afk_jobs:workStateSv', id, true)
			SetPlayerInvincible(player, true)
			SetEntityCoordsNoOffset(player, spot.pos)
			Wait(250)
			SetEntityHeading(player, spot.heading)
			Wait(250)
			FreezeEntityPosition(player, true)
			StayingAlive()
			JobTimer(option.time)
			TriggerEvent("mythic_progbar:client:progress", {
				name = "afk_work",
				duration = option.time,
				label = spot.progLabel,
				useWhileDead = false,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = spot.dict or false,
					anim = spot.lib or false,
				},
				prop = {
					prop = spot.prop or false,
				}
			}, function(status)
				if not status then
					afkActive = false
					if canRaid then canRaid = false end
					if pay == 'money' then
						TriggerServerEvent('afk_jobs:reward', type, option.value)
					elseif pay == 'item' then
						TriggerServerEvent('afk_jobs:rewardItem', type, option.value)
					end
				else
					afkActive = false
					if canRaid then canRaid = false end
					while timerActive do Wait(500); end
					if pay == 'money' then
						TriggerServerEvent('afk_jobs:reward', type, option.value, partialPay)
					elseif pay == 'item' then
						TriggerServerEvent('afk_jobs:rewardItem', type, option.value, partialPay)
					end
				end
				TriggerServerEvent('afk_jobs:workStateSv', id, false)
				ClearPedTasks(player)
				SetPlayerInvincible(player, false)
				FreezeEntityPosition(player, false)
			end)
		end
    end, function(data, menu)
        menu.close()
		afkActive = false
		if canRaid then canRaid = false end
    end)
end

function StayingAlive()
	if Config.AutoHeal then
		CreateThread(function()
			while true do
				Wait(100)
				if afkActive then
					TriggerEvent('esx_status:set', 'hunger', 1000000)
					TriggerEvent('esx_status:set', 'thirst', 1000000)
					if Config.HealStress then
						TriggerEvent('esx_status:set', 'stress', 10)
					end
				else
					break
				end
				Wait(Config.HealFrequency)
			end
		end)
	end
end

function JobTimer(time)
	local start = time
	timer = time
	timerActive = true
	CreateThread(function()
		while true do
			Wait(0)
			if afkActive then
				Wait(Config.TimerCheck)
				if timer > 0 then
					timer = timer - Config.TimerCheck
				elseif timer <= 0 then
					timer = 0
					timerActive = false
					break
				end
			else
				partialPay = (1 - Round((timer / start), 2))
				timer = 0
				timerActive = false
				break
			end
		end
	end)
end

RegisterNetEvent('afk_jobs:workStateCl')
AddEventHandler('afk_jobs:workStateCl', function(id, state)
	Config.AFK[id].active = state
end)

RegisterNetEvent('afk_jobs:raidStateCl')
AddEventHandler('afk_jobs:raidStateCl', function(state)
	Config.Raid.active = state
end)

RegisterNetEvent('afk_jobs:raidedCl')
AddEventHandler('afk_jobs:raidedCl', function()
	if canRaid then
		TriggerEvent('mythic_progbar:client:cancel')
		clientNotify(Lang['raided'])
	end
end)

function Round(number, places)
    local multiplier = 10^(places)
    return math.floor(number * multiplier + 0.5) / multiplier
end
