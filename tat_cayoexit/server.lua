ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) 
ESX = obj end)

AddEventHandler('esx:playerDropped', function(source, cb, GetDistanceBetweenCoords)
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT position FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(position)

        if position then
			print(('[cayo perico] [^2INFO^7] "%s" exited from cayo perico'):format(xPlayer.identifier))
		end

        cb(position)
    end)
end)

