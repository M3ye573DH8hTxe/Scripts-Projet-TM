util.AddNetworkString("CRP::Identity:Client:OpenInterfaceChangeName")
util.AddNetworkString("CRP::Identity:Server:ChangeName")


net.Receive("CRP::Identity:Server:ChangeName", function ( len, ply )

	local new_name = net.ReadString()

	if not IsValid(ply) or not isstring(new_name) then return end

	CitadelleRP.Identity:ChangeRPName( ply, new_name )

end)


util.AddNetworkString("CRP::Identity:Presentation:Server")
util.AddNetworkString("CRP::Identity:Presentation:Client")

net.Receive("CRP::Identity:Presentation:Server", function( len, ply )

	local typePresentation = net.ReadString()
	if not isstring(typePresentation) then return end

	local player = net.ReadEntity()

	CitadelleRP.API:switch (typePresentation,

		CitadelleRP.API:case("Presentation:Send", function()


			net.Start("CRP::Identity:Presentation:Client")
				net.WriteString("Presentation:Receive")
				net.WriteEntity(ply)
			net.Send(player)

		end),

		CitadelleRP.API:case("Presentation:Response", function()

			local response = net.ReadBool()
			if response then
				
				net.Start("CRP::Identity:Presentation:Client")
					net.WriteString("Presentation:ReceiveBack")
					net.WriteEntity(ply)
				net.Send(player)

				DarkRP.notify(ply, 1, 5, "Vous êtes désormais amis avec " .. player:Nick() .. ".")
				DarkRP.notify(player, 1, 5, "Vous êtes désormais amis avec " .. ply:Nick() .. ".")

				return
			end

			DarkRP.notify(player, 1, 5, ply:Nick() .. " a refusé de se présenter à vous !")


		end),


		CitadelleRP.API:default( function() print("[PRESENTATION-MANAGE] Aucune valeur : Contactez un administrateur") end)
	)


end)

