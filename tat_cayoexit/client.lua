local zones = {
	{ ['x'] = 1847.916015625, ['y'] = 3675.8190917968, ['z'] = 33.767009735108},

}

local notifIn = false
local notifOut = false
local closestZone = 1


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	for i = 1, #zones, 1 do
		local szBlip = AddBlipForCoord(zones[i].x, zones[i].y, zones[i].z)
		SetBlipAsShortRange(szBlip, true)
		SetBlipColour(szBlip, 2)  
		SetBlipSprite(szBlip, 398) 
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("SAFE ZONE")
		EndTextCommandSetBlipName(szBlip)
	end
end)


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
		local minDistance = 100000
		for i = 1, #zones, 1 do
			dist = Vdist(zones[i].x, zones[i].y, zones[i].z, x, y, z)
			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end
		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= 50.0 then  
			if not notifIn then																			  
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>You are in a SafeZone</b>",
					type = "success",
					timeout = (3000),
					layout = "bottomcenter",
					queue = "global"
				})
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				TriggerEvent("pNotify:SendNotification",{
					text = "<b style='color:#1E90FF'>You are in NO LONGER a SafeZone</b>",
					type = "error",
					timeout = (3000),
					layout = "bottomcenter",
					queue = "global"
				})
				notifOut = true
				notifIn = false
			end
		end
		if notifIn then
			TriggerClientEvent('esx:onPlayerSpawn')

local firstSpawn, PlayerLoaded = true, false

AddEventHandler("onClientMapStart", function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

AddEventHandler('esx:onPlayerSpawn', function()

	if firstSpawn then
		firstSpawn = false

		if zones then
			while not PlayerLoaded do
				Citizen.Wait(1000)
                setEntityCoords(PlayerPedId(), -1688.43811035156, -1073.62536621094, 13.1521873474121)				
			end)
		end
	end
end)