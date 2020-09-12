util.AddNetworkString("Munitions:OpenCaisse")
util.AddNetworkString("Munitions:Acheter")


net.Receive("Munitions:Acheter", function(len, ply)


	local moneyPlayerToBuyWeapon = ply:getDarkRPVar("money")

	local entity = net.ReadString()

	local priceE = net.ReadInt(32)

	if moneyPlayerToBuyWeapon < priceE and priceE ~= 0 then		
		return
	end

	local vendeur = net.ReadEntity()

	if ply == vendeur then
		
		DarkRP.notify(vendeur, 0, 4, "Vous ne pouvez pas vous acheter des munitions.")
		return
	end


	vendeur:addMoney(priceE)
	DarkRP.notify(vendeur, 0, 5, ply:Nick() .. " vous a acheté 100 munitions de type " .. entity)

	ply:addMoney(-priceE)
	ply:GiveAmmo(100, entity, false)




end)