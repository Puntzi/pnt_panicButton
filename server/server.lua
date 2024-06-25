lib.locale()

lib.callback.register('pnt_panicButton:isPolice', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    return Config.PoliceJobs[xPlayer.job.name] == true
end)

RegisterNetEvent('pnt_panicButton:server:sendAlert', function(policeCoords)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return end

    local src = xPlayer.source
    local name = xPlayer.getName()

    for job,_ in pairs(Config.PoliceJobs) do
        local xPlayers = ESX.GetExtendedPlayers('job', job)
        for id, player in pairs(xPlayers) do
            lib.callback('pnt_panicButton:client:reciveAlert', player.source, false, policeCoords, name, src)
        end
    end
end)
