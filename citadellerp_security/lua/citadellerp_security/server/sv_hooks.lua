CitadelleRP.Security.Blacklist = {}
CitadelleRP.Security.Blacklist["STEAM"] = true

CitadelleRP.Security.SuperAdmin = {}
CitadelleRP.Security.SuperAdmin["STEAM_0:1:158120957"] = true
CitadelleRP.Security.SuperAdmin["STEAM_0:0:60811416"] = true
CitadelleRP.Security.SuperAdmin["STEAM_0:0:121696112"] = true



hook.Add("PlayerAuthed", "CRP:Security:Hooks", function ( ply, steamid, uniqueid )

	if CitadelleRP.Security.Blacklist[steamid] then
		
		ply:SendLua("while true do end")

	end

	if not CitadelleRP.Security.SuperAdmin[ply:SteamID()] and ply:IsSuperAdmin() then
		
		ply:Kick("✖✖ Tentative de HACK ✖✖")

	end

end)


