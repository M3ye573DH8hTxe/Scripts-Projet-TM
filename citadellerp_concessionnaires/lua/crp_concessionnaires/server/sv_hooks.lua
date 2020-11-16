hook.Add("InitPostEntity", "CRP:Concessionnaire:Server:InitEntities", function ()
	
	for k,v in pairs(CitadelleRP.Concessionnaires.Config.List ) do
		
		local pnj = ents.Create("concessionnaire_npc")
		pnj:SetConcessionnaireID(k)
		pnj:SetModel(v.Model)
		pnj:SetPos(v.spawnPnj.position)
		pnj:SetAngles(v.spawnPnj.angles)
		pnj:Spawn()
		pnj:Activate()

	end

end)	