ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('rpoulet')
AddEventHandler('rpoulet', function()
    local item = "bdp"
    local limiteitem = 50
    local xPlayer = ESX.GetPlayerFromId(source)
    local nbitemdansinventaire = xPlayer.getInventoryItem(item).count
    

    if nbitemdansinventaire >= limiteitem then
        TriggerClientEvent('esx:showNotification', source, "T\'as pas assez de place dans ton inventaire !")
    else
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Récolte en cours...")
    end
end)

RegisterNetEvent('couisse')
AddEventHandler('couisse', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local bdp = xPlayer.getInventoryItem('bdp').count
    local couisse = xPlayer.getInventoryItem('couisse').count

    if couisse > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que tu ne puisses plus porter de couisse ...')
    elseif bdp < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de poulet pour traiter')
    else
        xPlayer.removeInventoryItem('bdp', 1)
        xPlayer.addInventoryItem('couisse', 2)    
    end
end)

RegisterNetEvent('ctenders')
AddEventHandler('ctenders', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local couisse = xPlayer.getInventoryItem('couisse').count
    local tenders = xPlayer.getInventoryItem('tenders').count

    if tenders > 50 then
        TriggerClientEvent('esx:showNotification', source, '~r~Il semble que ton Bucket est plein ...')
    elseif couisse < 3 then
        TriggerClientEvent('esx:showNotification', source, '~r~Pas assez de cuisse pour faire frire les tenders')
    else
        xPlayer.removeInventoryItem('couisse', 5)
        xPlayer.addInventoryItem('tenders', 1)    
    end
end)

local argent = math.random(50,75)


RegisterServerEvent('ventetenders')
AddEventHandler('ventetenders', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    local tenders = 0

	for i=1, #xPlayer.inventory, 1 do
		local item = xPlayer.inventory[i]

		if item.name == "tenders" then
			tenders = item.count
		end
	end
    
    if tenders > 0 then
        xPlayer.removeInventoryItem('tenders', 1)
        xPlayer.addMoney(argent)
    else 
        TriggerClientEvent('esx:showNotification', xPlayer.source, 'T\'as finis de vendre tes tenders akhy, cavale sans rouspester heeeeeen')
    end
end)