local firstSpawn, PlayerLoaded = true, false

AddEventHandler("onClientMapStart", function()
	exports.spawnmanager:spawnPlayer()
	Citizen.Wait(5000)
	exports.spawnmanager:setAutoSpawn(false)
end)

AddEventHandler('esx:onPlayerSpawn', function()

	if firstSpawn then
		firstSpawn = false

		if Config.ExitRadius then
			while not PlayerLoaded do
				Citizen.Wait(1000)
                setEntityCoords(PlayerPedId(), x, y, z)				
			end)
		end
	end
end)