util.AddNetworkString("CRP::Police:Bac:CasierOpen")
util.AddNetworkString("CRP::Police:Bac:Server")


net.Receive("CRP::Police:Bac:Server", function( len, ply )

	local typeNet = net.ReadString()
	if not isstring(typeNet) then return end
	CitadelleRP.API:switch (typeNet,

		CitadelleRP.API:case("ServerBac:Reset", function()

			local steamid = ply:SteamID64()
			local CharacterCreatorFil = file.Read("charactercreator/"..steamid.."/kobra_character_2.txt", "DATA") or ""
			local CharacterCreatorTable = util.JSONToTable(CharacterCreatorFil) or {}


			ply:SetModel(CharacterCreatorTable["CharacterCreatorModel"])
			DarkRP.notify(ply, 0, 3, "Votre costume de civil a été enlevé.")

		end),

		CitadelleRP.API:case("ServerBac:Equip", function()

			local model = net.ReadString()
			ply:SetModel(model)
			DarkRP.notify(ply, 0, 3, "Vous avez mis votre costume civil.")

		end),

		CitadelleRP.API:default( function() print("[BAC - TYPE] Aucune valeur : Contactez un administrateur") end)
	)


end)