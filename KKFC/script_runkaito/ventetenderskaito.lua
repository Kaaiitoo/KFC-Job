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


Config2              = {}
Config2.DrawDistance = 50
Config2.Size         = {x = 1.0, y = 1.0, z = 1.0}
Config2.Color        = {r = 255, g = 0, b = 0}
Config2.Type         = -1

local VENTEKAITO = {
    {x = 961.77, y = -2111.86, z = 31.94}        
}  

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local coords, letSleep = GetEntityCoords(PlayerPedId()), true

        for k in pairs(VENTEKAITO) do
            if (Config2.Type ~= -1 and GetDistanceBetweenCoords(coords, VENTEKAITO[k].x, VENTEKAITO[k].y, VENTEKAITO[k].z, true) < Config2.DrawDistance) then
                DrawMarker(Config2.Type, VENTEKAITO[k].x, VENTEKAITO[k].y, VENTEKAITO[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config2.Size.x, Config2.Size.y, Config2.Size.z, Config2.Color.r, Config2.Color.g, Config2.Color.b, 100, false, true, 2, false, false, false, false)
                letSleep = false
            end
        end

        if letSleep then
            Citizen.Wait(500)
        end
    end
end)

RMenu.Add('vente', 'main', RageUI.CreateMenu("Vente", "Lancement de la vente..."))


Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('vente', 'main'), true, true, true, function()

            RageUI.ButtonWithStyle("Vendre tes tenders", nil, {RightLabel = "~r~38$/u"},true, function(Hovered, Active, Selected)
                if (Selected) then   
                    TriggerServerEvent('ventetenders')
                end
            end)

        end, function()
        end)

        Citizen.Wait(0)
    end
end)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            for k in pairs(VENTEKAITO) do
                if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kfc' then 
    
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, VENTEKAITO[k].x, VENTEKAITO[k].y, VENTEKAITO[k].z)
                DrawMarker(20, 961.77, -2111.86, 30.94+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
    
            
                if dist <= 1.0 then
                    RageUI.Text({
    
                        message = "Appuyez sur [~r~E~w~] pour vendre tes tenders ",
            
                        time_display = 1
            
                    })
                    if IsControlJustPressed(1,51) then
                        RageUI.Visible(RMenu:Get('vente', 'main'), not RageUI.Visible(RMenu:Get('vente', 'main')))
                    end
                end
            end
        end
        end
    end)
