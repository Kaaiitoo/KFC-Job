ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


---------------- FONCTIONS ------------------

RMenu.Add('couisse', 'traitement', RageUI.CreateMenu("Cuisse", "Lancement du processus..."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('couisse', 'traitement'), true, true, true, function()

                RageUI.ButtonWithStyle("Transformation des cuisses", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then              
                        traitementcouisse()
                        RageUI.CloseAll()
                    end
                end)
            end, function()
            end)
    
            Citizen.Wait(0)
        end
    end)

---------------------------------------------

    ---------------------------------------- Position du Menu --------------------------------------------
    
            local traitementpossible = false
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                while true do
                    Wait(0)
            
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        if IsEntityAtCoord(PlayerPedId(), -0.0, -0.0, 0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "Appuyez sur [~b~E~w~] pour déplumer le poulet",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('couisse', 'traitement'), not RageUI.Visible(RMenu:Get('couisse', 'traitement')))
                                    end
                                else
                                    traitementpossible = false
                                end
                            end    
                    end)
    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function traitementcouisse()
    if not traitementpossible then
        traitementpossible = true
    while traitementpossible do
            Citizen.Wait(2000)
            ExecuteCommand('e mechanic')
            TriggerServerEvent('couisse')
    end
    else
        traitementpossible = false
    end
end

----------------------------------------

local LEMENUESTLAA = {
    {x = -95.82, y = 6207.18, z = 31.02}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(LEMENUESTLAA) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kfc' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, LEMENUESTLAA[k].x, LEMENUESTLAA[k].y, LEMENUESTLAA[k].z)
			DrawMarker(20, -95.82, 6207.18, 30.02+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
				RageUI.Text({

					message = "Appuyez sur [~r~E~w~] pour déplumer votre poulet ",
		
					time_display = 1
		
				})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('couisse', 'traitement'), not RageUI.Visible(RMenu:Get('couisse', 'traitement')))
                end
            end
        end
    end
    end
end)

