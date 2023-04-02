
RegisterCommand(config.command, function(src, args, rawCommand)
    local toplayer = tonumber(args[1])
    local fromplayer = src
    if (toplayer == nil) then
        TriggerClientEvent('GetClosestPlayer', fromplayer)
    else
        TriggerClientEvent('distancecheck', fromplayer, toplayer)
    end
end, config.useAcePerms)


RegisterNetEvent('TriggerBlindfold', function(toplayer)
    TriggerClientEvent('blindfold', toplayer)
end)

exports('TriggerBlindfold', function(toplayer)
    TriggerClientEvent('blindfold', toplayer)
end)
