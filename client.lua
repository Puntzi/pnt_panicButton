lib.locale()
local blips = {}
local disabled = false

function createBlip(policeCoords, policeName, policeSource)
    local policeId = GetPlayerFromServerId(policeSource)

    if not NetworkIsPlayerActive(policeId) then return end 

    blip = AddBlipForEntity(GetPlayerPed(policeId))
    SetBlipSprite(blip, Config.Blips.sprite)
    SetBlipScale(blip, Config.Blips.scale)
    SetBlipColour(blip, Config.Blips.color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(locale("name_officer", policeName))
    EndTextCommandSetBlipName(blip)
    SetBlipRoute(blip, true)
    SetBlipRouteColour(blip, Config.Blips.color)

    return blip
end

function activateButton()
    local ped = cache.ped
    local isPolice = lib.callback.await('pnt_panicButton:isPolice', false)

    if not isPolice then
        return lib.notify({
            title = locale("you_are_not_a_police"),
            type = 'error'
        })
    end

    local policeCoords = GetEntityCoords(ped)

    TriggerServerEvent('pnt_panicButton:server:sendAlert', policeCoords)

    lib.notify({
        title = locale("alert_sent"),
        type = 'success'
    })
end

function openMenu()
    local options = {}
    
    local isPolice = lib.callback.await('pnt_panicButton:isPolice', false)

    if not isPolice then
        return lib.notify({
            title = locale("you_are_not_a_police"),
            type = 'error'
        })
    end

    for i = 1, #blips, 1 do
        if blips[i].blipId then 

            table.insert(options, {
                title = locale("name_officer", blips[i].name),
                icon = "fa-check",
                iconColor = 'green',
                onSelect = function(args)
                    interactMenu(args)
                end,
                args = {
                    tableId = i,
                    policeCoords = blips[i].coords,
                    name = blips[i].name,
                    blipId = blips[i].blipId,
                    policeSource = blips[i].source
                }
            })

        else
            
            table.insert(options, {
                title = locale("name_officer", blips[i].name),
                icon = "fa-exclamation",
                iconColor = 'red',
                arrow = true,
                onSelect = function(args)
                    interactMenu(args)
                end,
                args = {
                    tableId = i,
                    policeCoords = blips[i].coords,
                    name = blips[i].name,
                    policeSource = blips[i].source
                }
            })

        end
    end

    lib.registerContext({
        id = 'blip_menu',
        title = locale("title_menu"),
        options = options
    })

    lib.showContext('blip_menu')
end

function interactMenu(args)
    if args.blipId then disabled = true else disabled = false end

    lib.registerContext({
        id = "interact_menu",
        title = locale("accept_or_cancel_alert"),
        menu = "blip_menu",
        options = {
            {
                title = locale("accept_alert"),
                icon = "fa-check",
                iconColor = 'green',
                disabled = disabled,
                onSelect = function()
                    blips[args.tableId].blipId = createBlip(args.policeCoords, args.name, args.policeSource)
                end
            },
            {
                title = locale("delete_alert"),
                icon = "fa-times",
                iconColor = 'red',
                onSelect = function()
                    RemoveBlip(args.blipId)
                    table.remove(blips, args.tableId)
                end
            }
        }
    })

    lib.showContext("interact_menu")
end


lib.callback.register('pnt_panicButton:client:reciveAlert', function(policeCoords, policeName, policeSource)

    lib.notify({
        title = locale("officer_alerted", policeName),
        type = 'alert'
    })

    local info = {
        coords = policeCoords,
        name = policeName,
        source = policeSource,
    }

    table.insert(blips, info)

    for i = 1, 10, 1 do
        PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
        Wait(300)
    end
end)

RegisterCommand('panicButton', function()
    activateButton()
end)

exports('activateButton', activateButton)

RegisterKeyMapping('panicButton', 'Activate panic button for police', 'keyboard', Config.ButtonForPanicButton)

RegisterCommand('openMenu', function()
    openMenu()
end)

exports('openMenu', openMenu)

RegisterKeyMapping('openMenu', 'Open menu for panic button', 'keyboard', Config.ButtonForPanicButtonMenu)
