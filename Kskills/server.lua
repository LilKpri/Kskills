ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('esx:playerLoaded', function(source) 
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('Kskills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
			else
				MySQL.Async.execute('INSERT INTO `Kskills` (`identifier`, `strength`, `stamina`, `driving`, `shooting`, `fishing`, `drugs`) VALUES (@identifier, @strength, @stamina, @driving, @shooting, @fishing, @drugs);',
				{
				['@identifier'] = xPlayer.identifier,
				['@strength'] = 0,
				['@stamina'] = 0,
				['@driving'] = 0,
				['@shooting'] = 0,
				['@fishing'] = 0,
				['@drugs'] = 0
				}, function ()
				end)
		end
	end)
end)

function updatePlayerInfo(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('Kskills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
		end
	end)
end

RegisterServerEvent("Kskills:addStamina")
AddEventHandler("Kskills:addStamina", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'Tu te sens ~g~' .. round(amount, 2) .. '% ~s~plus rapide!')
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `Kskills` SET `stamina` = @stamina WHERE `identifier` = @identifier',
			{
			['@stamina'] = (skillInfo[1].stamina + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("Kskills:addStrength")
AddEventHandler("Kskills:addStrength", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'You feel ~g~' .. round(amount, 2) .. '% ~s~stronger!')
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `Kskills` SET `strength` = @strength WHERE `identifier` = @identifier',
			{
			['@strength'] = (skillInfo[1].strength + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("Kskills:addDriving")
AddEventHandler("Kskills:addDriving", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'Tu deviens ~g~' .. round(amount, 2) .. '% ~s~meilleur a la conduite!')
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `Kskills` SET `driving` = @driving WHERE `identifier` = @identifier',
			{
			['@driving'] = (skillInfo[1].driving + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("Kskills:addFishing")
AddEventHandler("Kskills:addFishing", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'Tu deviens ~g~' .. round(amount, 2) .. '% ~s~meilleur a la peche!')
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `Kskills` SET `fishing` = @fishing WHERE `identifier` = @identifier',
			{
			['@fishing'] = (skillInfo[1].fishing + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("Kskills:addDrugs")
AddEventHandler("Kskills:addDrugs", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('esx:showNotification', source, 'tu deviens ~g~' .. round(amount, 2) .. '% ~s~meilleur dans le trafic de ~y~drogue~s~!')
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `Kskills` SET `drugs` = @drugs WHERE `identifier` = @identifier',
			{
			['@drugs'] = (skillInfo[1].drugs + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

ESX.RegisterServerCallback('Kskills:getSkills', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `Kskills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		cb(skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
	end)
end)

print('~g~Started Kskills')
print('~b~Skill Script Made By Kpri')