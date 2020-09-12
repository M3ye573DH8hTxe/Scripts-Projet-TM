-- [Hook ID-NO-META]

hook.Add( "PlayerAuthed", "GENERATE_ID_NO_META", function ( ply, id )

	if IsValid(ply) then

		local steamID = id
		local steamID64 = util.SteamIDTo64(steamID)

		local random = math.Rand(0.01, 1)

	   	local StringSteam64 = string.format(steamID64)

	   	local intInSteam64 = StringSteam64:sub(9, 11)


	   	local final = math.ceil((intInSteam64 * random))

	   	ply:SetNWString("ID_META", "#" .. final)

	   	ply:ChatPrint("Votre ID ANTI-META est : " .. final)
	   	
	end
	
end)


-- [Commande ID-NO-META]

concommand.Add( "myidmeta", function( ply )

	ply:ChatPrint( "Votre ID ANTI-META : " ..  ply:GetNWString("ID_META", 0))

end )

