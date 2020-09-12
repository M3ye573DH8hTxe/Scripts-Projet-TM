hook.Add("InitPostEntity", "CRP:Shop:Server:InitEntities", function ()
	
	for k,v in pairs(CitadelleRP.Shop.Config.List) do
		
		local pnj = ents.Create("vendeur_polyvalent")
		pnj:SetShopID(k)
		pnj:SetModel(v.Model)
		pnj:SetPos(v.position)
		pnj:SetAngles(v.angles)
		pnj:Spawn()
		pnj:Activate()

	end

end)	
