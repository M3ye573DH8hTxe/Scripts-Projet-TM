hook.Add("Initialize", "CRP:Family:Initialize", function()

	CitadelleRP.Family:Initialize()
	
end)


hook.Add("PlayerInitialSpawn", "CRP:Family:Player:Initialize", function ( ply )

	CitadelleRP.Family:SyncPlayer(ply)

end)


hook.Add("PlayerSay", "CRP:Family:Player:Commands", function(ply, text)
    if IsValid(ply) && string.lower(text) == "!family" or string.lower(text) == "/family" then
    	if not ply:HasFamily() then return end
		net.Start("CRP::Family:Client:OpenMemberInterface")
			net.WriteString(ply:GetFamilyName())
		net.Send(ply)

    end
end)