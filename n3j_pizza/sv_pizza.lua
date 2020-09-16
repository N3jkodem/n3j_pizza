ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('n3j_dodajpizze')
AddEventHandler('n3j_dodajpizze', function()
	local _source = source 
	local xPlayer  = ESX.GetPlayerFromId(source)
	local pizzerka = xPlayer.getInventoryItem('pizza1')["count"]


	if pizzerka <= 5 then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Przygotowałeś pizzę'})
		Citizen.Wait(1000)
		xPlayer.addInventoryItem('pizza1',1)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Nie masz już miejsca na pizzę'})
	end
end)


RegisterServerEvent('n3j_usunprzygotowana')
AddEventHandler('n3j_usunprzygotowana', function()
	local _source = source 
	local xPlayer = ESX.GetPlayerFromId(source)
    local pizzerkausun = xPlayer.getInventoryItem('pizza1')["count"]

	if pizzerkausun > 0 then
		xPlayer.removeInventoryItem('pizza1',1)
	elseif pizzerkausun < 0 then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Nie masz przygotowanej pizzy'})
	end 
end)

RegisterServerEvent('n3j_dodajspakowana')
AddEventHandler('n3j_dodajspakowana', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local spakowanapizzerka = xPlayer.getInventoryItem('pizza1')["count"]

	if spakowanapizzerka > 0 then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Spakowałeś pizzę'})
		Citizen.Wait(1000)
		xPlayer.removeInventoryItem('pizza1',1)
		xPlayer.addInventoryItem('pizza2',1)
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Nie masz przygotowanej pizzy'})
	end
end)




RegisterServerEvent('n3j_wynagrodzenie')
AddEventHandler('n3j_wynagrodzenie', function()
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local spakowanapizza = xPlayer.getInventoryItem('pizza2')["count"]
	local wynagrodzenie = math.random(45,55)

	if spakowanapizza >=1 then
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Dostarczyłeś pizzę i zarobiłeś:  ' .. wynagrodzenie .. '$'})
		xPlayer.addMoney(wynagrodzenie)
		Citizen.Wait(1000)
		xPlayer.removeInventoryItem('pizza2',1)
	else 
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Próbowałeś dać klientowi puste pudełko!?'})
	end 
end)


