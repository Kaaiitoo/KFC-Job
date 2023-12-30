ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RMenu.Add('kaitolpb', 'main', RageUI.CreateMenu("Alimentation", "Pour la consommation des clients"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('kaitolpb', 'main'), true, true, true, function()    
         
        for k, v in pairs(Config.kaitoAlimitem) do
            RageUI.ButtonWithStyle(v.nom, nil, {RightLabel = " ~g~$"..v.prix},true, function(Hovered, Active, Selected)
                if (Selected) then  
                local quantite = 1    
                local item = v.item
                local prix = v.prix
                local nom = v.nom    
                TriggerServerEvent('kfckaito:achatbar', v, quantite)
            end
            end)

        end
        end, function()
        end)
            Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
                local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
                local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Config.pos.kaitoAlim.position.x, Config.pos.kaitoAlim.position.y, Config.pos.kaitoAlim.position.z)
                DrawMarker(20, 0.0, -0.0, 0.0+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 250, 3, 200, 255, 0, 1, 2, 0, nil, nil, 0)
            if jobdist <= 2.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kfc' then  
                RageUI.Text({

                    message = "Appuyez sur [~r~E~w~] pour passer une commande à Sofia",

                    time_display = 1

                })
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('kaitolpb', 'main'), not RageUI.Visible(RMenu:Get('kaitolpb', 'main')))
                    end   
                end
               end 
        end
end)


Citizen.CreateThread(function()
    local hash = GetHashKey("a_f_y_vinewood_04")
    while not HasModelLoaded(hash) do
    RequestModel(hash)
    Wait(20)
    end
    ped = CreatePed("PED_TYPE_CIVFEMALE", "a_f_y_vinewood_04", 27.17, -1315.71, 28.52, 356.22,  true, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
end)
