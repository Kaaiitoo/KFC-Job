ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}
local societykaitomoney = nil

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

RMenu.Add('kaitoKFC', 'boss', RageUI.CreateMenu("KFC", "Options administratives.."))
Citizen.CreateThread(function()
    while true do

        RageUI.IsVisible(RMenu:Get('kaitoKFC', 'boss'), true, true, true, function()

            RageUI.Separator("↓ ~r~  Montant du KFC ~s~↓")

            if societykaitomoney ~= nil then
                RageUI.ButtonWithStyle("Argent de societé :", nil, {RightLabel = "~b~$" .. societykaitomoney}, true, function()
                end)
            end
            RageUI.Separator("↓ ~y~  Panel de comptabilité  ~s~↓")

            
            RageUI.ButtonWithStyle("Déposer de l'argent",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'deposit_money_amount_' .. 'kfc',
                    {
                        title = ('Montante')
                    }, function(data, menu)
        
                        local amount = tonumber(data.value)
        
                        if amount == nil then
                            ESX.ShowNotification('Montante Invalide')
                        else
                            menu.close()
                            TriggerServerEvent('esx_society:depositMoney', 'kfc', amount)
                            RefreshemsMoney()
                        end
                    end)
                end
            end) 

            RageUI.ButtonWithStyle("Retirer de l'argent",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'withdraw_society_money_amount_' .. 'kfc',
                    {
                        title = ('Montante')
                    }, function(data, menu)
                    local amount = tonumber(data.value)

                if amount == nil then
                    ESX.ShowNotification('Montante Invalide')
                else
                    menu.close()
                    TriggerServerEvent('esx_society:withdrawMoney', 'kfc', amount)
                    RefreshemsMoney()
                        end
                    end)
                end
            end)

            RageUI.Separator("↓ ~g~  Management  ~s~↓")

            RageUI.ButtonWithStyle("Gestion de l'entreprise",nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
                if Selected then
                    aboss()
                    RageUI.CloseAll()
                end
            end)


        end, function()
        end, 1)
                        Citizen.Wait(0)
                                end
                            end)

---------------------------------------------

local position = {
    {x = 347.15, y = -885.08, z = 29.33}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(position) do
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'kfc' and ESX.PlayerData.job.grade_name == 'boss' then 

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)
            DrawMarker(20, 347.15, -885.08, 28.63, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 255, 0, 255, 0, 1, 2, 0, nil, nil, 0)

        
            if dist <= 1.0 then
                RageUI.Text({

                    message = "Appuyez sur [~r~E~w~] pour accéder au panel administratif",

                    time_display = 1

                })
                if IsControlJustPressed(1,51) then
                    RefreshemsMoney()
                    RageUI.Visible(RMenu:Get('kaitoKFC', 'boss'), not RageUI.Visible(RMenu:Get('kaitoKFC', 'boss')))
                end
            end
        end
    end
    end
end)

function RefreshemsMoney()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
            Updatesocietykaitomoney(money)
        end, ESX.PlayerData.job.name)
    end
end

function Updatesocietykaitomoney(money)
    societykaitomoney = ESX.Math.GroupDigits(money)
end

function aboss()
    TriggerEvent('esx_society:openBossMenu', 'kfc', function(data, menu)
        menu.close()
    end, {wash = false})
end



----------------------------------------------------------------------
--######################### BLIPS #####################

PlayerData = {}

local done = false

ESX = nil
 Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
    done = true
end)
--==============KFC!================---

local kfcblips = { 
	 {title="Grappillage des poulets", colour=1, id=478, x = -62.38, y = 6239.85, z = 31.09},
}
local kfcblips2 = { 
  {title="Vente des Tenders", colour=1, id=478, x = 961.77, y = -2111.86, z = 31.94},
}
local kfcblips3 = { 
    {title="Achat des aliments", colour=1, id=478,   x = 27.17, y = -1315.71, z = 29.52}, 
}

--kfc blips
 Citizen.CreateThread(function() 
    while not done do
        Citizen.Wait(10)
    end
    if PlayerData.job.name == 'kfc' then 
        for _, info in pairs(kfcblips) do 
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, false)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
      done = true
    end
end
end)

Citizen.CreateThread(function() 
  while not done do
      Citizen.Wait(10)
  end
  if PlayerData.job.name == 'kfc' then 
      for _, info in pairs(kfcblips2) do 
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.8)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
    done = true
  end
end
end)


Citizen.CreateThread(function() 
    while not done do
        Citizen.Wait(10)
    end
    if PlayerData.job.name == 'kfc' then 
        for _, info in pairs(kfcblips3) do 
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, false)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
      done = true
    end
end
end)