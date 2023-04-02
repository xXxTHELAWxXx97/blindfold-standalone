local blindfolded = false

RegisterNetEvent('blindfold', function()
    if (blindfolded == false) then
        blindfolded = true
        bag = CreateObject(GetHashKey('prop_money_bag_01'), 0, 0, 0, true, true, true)
        AttachEntityToEntity(bag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60, true, true, false, true, 1, true)
        print('Attached Bag')
        SendNUIMessage({action = 'open'})
        print('NUI sent.')
    else
        blindfolded = false
        DeleteEntity(bag)
        SetEntityAsNoLongerNeeded(bag)
        SendNUIMessage({action = 'close'})
    end
end)

function blindfoldnotify(message)
    showNotification(message)
end

function showNotification(message)
    BeginTextCommandThefeedPost('STRING')
    AddTextComponentSubstringPlayerName(message)
    EndTextCommandThefeedPostTicker(false, true)
end

RegisterNetEvent('GetClosestPlayer', function()
    local radius = config.distance
    local players = GetActivePlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for _,playerId in ipairs(players) do
        local targetPed = GetPlayerPed(playerId)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local distance = #(targetCoords-playerCoords)
            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = playerId
                closestDistance = distance
            end
        end
    end
	if closestDistance ~= -1 and closestDistance <= radius then
		print(GetPlayerServerId(closestPlayer))
        TriggerEvent('distancecheck', GetPlayerServerId(closestPlayer))
	else
		blindfoldnotify('No players nearby to blindfold')
	end
end)

RegisterNetEvent('distancecheck', function(target)
    local toplayer = GetPlayerFromServerId(target)
    local fromcoords = GetEntityCoords(PlayerPedId())
    local tocoords = NetworkGetPlayerCoords(toplayer)
    local distance = GetDistanceBetweenCoords(fromcoords.x, fromcoords.y, fromcoords.z, tocoords.x, tocoords.y, tocoords.z, true)
    print('from player ' .. PlayerPedId() .. ' is at ' .. fromcoords.x .. ' ' .. fromcoords.y .. ' ' .. fromcoords.z)
    print('to player is at ' .. tocoords.x .. ' ' .. tocoords.y .. ' ' .. tocoords.z)
    print('distance is ' .. distance)
    if (distance <= config.distance) then
        TriggerServerEvent('TriggerBlindfold', target)
        blindfoldnotify('You have successfully blindfolded ' .. target)
    else
        blindfoldnotify('Player is too far away to blindfold')
    end
end)

exports('isBlindfolded', function()
    return blindfolded
end)