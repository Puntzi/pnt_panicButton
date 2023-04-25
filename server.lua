lib.locale()

lib.callback.register('pnt_panicButton:isPolice', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.job.name == Config.PoliceName then
        return true
    else
        return false
    end
end)

RegisterNetEvent('pnt_panicButton:server:sendAlert', function(policeCoords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local xPlayers = ESX.GetExtendedPlayers()
    
    for _, player in pairs(xPlayers) do
        if player.job.name == Config.PoliceName --[[ and not (player.source == xPlayer.source) ]] then
            lib.callback('pnt_panicButton:client:reciveAlert', player.source, false, policeCoords, xPlayer.getName(), xPlayer.source)
        end
    end
end)
