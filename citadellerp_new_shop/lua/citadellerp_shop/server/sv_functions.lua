function CitadelleRP.Shop:IsAllowToBuy(ent, num, perItem)

	if not IsValid(ent) then return end


	if not perItem then

		if self.Config.List[ent:GetShopID()].requiredJob ~= nil and #team.GetPlayers(self.Config.List[ent:GetShopID()].requiredJob) > 0 then

			return true
		end


		return false

	else


		if self.Config.List[ent:GetShopID()].Content[num].requiredJob ~= nil and #team.GetPlayers(self.Config.List[ent:GetShopID()].Content[num].requiredJob) > 0 then
			return true
		end

		return false

	end
end



function CitadelleRP.Shop:Buy(ply, ent, num)

	local money = ply:getDarkRPVar("money")
	local ID = ent:GetShopID()


	local price = self.Config.List[ID].Content[num].Price
	if price > money or price <= 0 then 

		DarkRP.notify(ply, 1, 3, "Désolé, vous n'avez pas assez d'argent !")
		return

	end


	local IsEnt = self.Config.List[ID].IsEnt
	if IsEnt then self:BuyEnt(ply, ent, num) return end


	local class = self.Config.List[ID].Content[num].Class
	local name = self.Config.List[ID].Content[num].Name

	if self:IsAllowToBuy(ent, num, false) then DarkRP.notify(ply, 1, 3, "Il y a un vendeur en ville. Va le voir...") return end

	if self.Config.List[ID].IsAmmo then
		
		ply:addMoney(-price)
		ply:GiveAmmo(100, class, false)

		DarkRP.notify(ply, 1, 3, "Vous avez acheté 100 munitions (-" .. DarkRP.formatMoney(price) .. ")")
		return
	end


	if ply:IsBlackListedWeapon(class) then return end

	ply:addMoney(-price)
	ply:Give(class)
	DarkRP.notify(ply, 1, 3, "Vous avez acheté " .. name .. " (-" .. DarkRP.formatMoney(price) .. ")")


end





function CitadelleRP.Shop:BuyEnt(ply, ent, num)

	if self:IsAllowToBuy(ent, num, true) then DarkRP.notify(ply, 1, 3, "Il y a un vendeur en ville. Va le voir...") return end

	local ID = ent:GetShopID()

	local price = self.Config.List[ID].Content[num].Price
	local class = self.Config.List[ID].Content[num].Class
	local name = self.Config.List[ID].Content[num].Name
	local model = self.Config.List[ID].Content[num].Model
	local IsSpawn = self.Config.List[ID].Content[num].IsSpawn

	if IsSpawn then
		
		ply:addMoney(-price)

		local entity = ents.Create( class )
		entity:SetModel( model )
		entity:SetPos( ply:GetPos()  )
		entity:Spawn()
		entity:SetOwner(ply)

		DarkRP.notify(ply, 1, 3, "Vous avez acheté " .. name .. " (-" .. DarkRP.formatMoney(price) .. ")")
		return
	
	end

	ply:addMoney(-price)

	CitadelleRP.API:switch (name,

		CitadelleRP.API:case("Kevlar", function()

			ply:SetArmor(100)
		end),

		CitadelleRP.API:default( function() print("[CitadelleRP.Shop] Aucune valeur : Contactez un administrateur") end)
	)

end


