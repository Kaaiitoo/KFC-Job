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

RMenu.Add('tenders', 'creation', RageUI.CreateMenu("Tenders", "Lancement du processus.."))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('tenders', 'creation'), true, true, true, function()

                RageUI.ButtonWithStyle("Faire frire les cuisses", nil, {}, true, function(Hovered, Active, Selected)
                    if (Selected) then              
                        traitementtenders()
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
    
            local traitementpossible2 = false
            Citizen.CreateThread(function()
                local playerPed = PlayerPedId()
                while true do
                    Wait(0)
            
                        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                        if IsEntityAtCoord(PlayerPedId(), -0.0, -0.0, 0.0, 1.5, 1.5, 1.5, 0, 1, 0) then 

                                   RageUI.Text({
                                    message = "Appuyez sur [~b~E~w~] pour faire des tenders",
                                    time_display = 1
                                })
                                    if IsControlJustPressed(1, 51) then
                                        RageUI.Visible(RMenu:Get('tenders', 'creation'), not RageUI.Visible(RMenu:Get('tenders', 'creation')))
                                    end
                                else
                                    traitementpossible2 = false
                                end
                            end    
                    end)
    

function notify(text)
   SetNotificationTextEntry('STRING')
   AddTextComponentString(text)
   DrawNotification(false, false)
end

function traitementtenders()
    if not traitementpossible2 then
        traitementpossible2= true
    while traitementpossible2 do
            Citizen.Wait(2000)
            ExecuteCommand('e mechanic')
            TriggerServerEvent('ctenders')
    end
    else
        traitementpossible2 = false
    end
end

----------------------------------------

local LEMENUESTLAAAAA = {
    {x = 341.16, y = -895.86, z = 29.33}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(LEMENUESTLAAAAA) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kfc' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, LEMENUESTLAAAAA[k].x, LEMENUESTLAAAAA[k].y, LEMENUESTLAAAAA[k].z)
			DrawMarker(20, 341.16, -895.86, 28.33+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
				RageUI.Text({

					message = "Appuyez sur [~r~E~w~] pour faire vos tenders",
		
					time_display = 1
		
				})
                if IsControlJustPressed(1,51) then
                    RageUI.Visible(RMenu:Get('tenders', 'creation'), not RageUI.Visible(RMenu:Get('tenders', 'creation')))
                end
            end
        end
    end
    end
end)

