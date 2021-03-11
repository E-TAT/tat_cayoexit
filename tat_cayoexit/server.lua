ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
ESX = obj end)

AddEventHandler('esx:playerDropped', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetcoord = vector3(1847.916015625,3675.8190917968,33.767009735108)
	local updateCoords = vector3(1688.43811035156,-1073.62536621094,13.1521873474121)
    local Coords = GetEntityCoords(GetPlayerPed(source))
    local distance = #(Coords.xy - targetcoord.xy)
    if distance < 200.0 then
        xPlayer.updateCoords(updatecoords) 
    end
end)